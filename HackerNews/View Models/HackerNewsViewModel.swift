//
//  HackerNewsViewModel.swift
//  HackerNews
//
//  Created by Ben Gabay on 2/28/23.
//

import Foundation
import Combine 

enum HackerNewsState: Equatable {
    case initialLoad
    case fetching
    case error(errorMessage: String)
    case loaded
    
    static func ==(lhs: HackerNewsState, rhs: HackerNewsState) -> Bool {
        switch(lhs, rhs) {
        case(.initialLoad, .initialLoad):
            return true
        case (.fetching, .fetching):
            return true
        case (.error(let message), .error(let secondMessage)):
            return message == secondMessage
        case (.loaded, .loaded):
            return true
        default:
            return false
        }
    }
}

@MainActor class HackerNewsViewModel: ObservableObject {

    private let service = HackerNewsRepository()

    // Get Story Ids first, then load story by page
    private var topStoryIds = [Int]()
    
    // Published
    @Published var topStories = [Story]()
    @Published var state: HackerNewsState = .initialLoad

    // Paging vars
    private var currentPage = 1
    private let maxPageLimit = 10
    private let batchSize = 50

    private var shouldNotLoadNextPage: Bool {
        return state == .fetching ||
            state == .initialLoad ||
            currentPage >= maxPageLimit ||
            topStoryIds.isEmpty
    }
    
    init() {
        Task {
            await fetchTopStories()
        }
    }
    
    // Initial fetch of Ids, then fetch the first page
    func fetchTopStories() async {
        await MainActor.run {
            state = .initialLoad
        }

        do {
            topStoryIds = try await service.fetchTopStoryIds()
            let firstStories = try await fetchFirstPage(ids: topStoryIds)
            await MainActor.run {
                topStories = firstStories
                state = .loaded
            }
        } catch {
            await MainActor.run {
                let errorString = (error as? FetchNewsError)?.description ?? "Error Found!\n\(error.localizedDescription)"
                state = .error(errorMessage: errorString)
            }
        }
    }

    // tightly coupled with fetch top stories, state changes will be made there
    func fetchFirstPage(ids: [Int]) async throws -> [Story] {
        if ids.isEmpty { throw FetchNewsError.topStoriesEmpty }
        let defaultBatchSize = {
            return topStoryIds.count < batchSize ? topStories.count : batchSize
        }()
        
        do {
            let stories = try await service.fetchStoriesAt(page: 0, batchSize: defaultBatchSize, stories: topStoryIds)
            print("fetched first page!")
            currentPage = 1
            return stories
        } catch {
            throw error
        }
    }
    
    func fetchNextPage() async {
        // If we're already loading something, don't load this
        if shouldNotLoadNextPage { return }

        do {
            state = .fetching
            let stories = try await service.fetchStoriesAt(page: currentPage, batchSize: batchSize, stories: topStoryIds)
            currentPage += 1
            self.topStories.append(contentsOf: stories)
            state = .loaded
        } catch {
            if Task.isCancelled {
                state = .error(errorMessage: "task cancelled")
                return
            }
            let errorString = (error as? FetchNewsError)?.description ?? "Error Found!\n\(error.localizedDescription)"
            state = .error(errorMessage: errorString)
        }
    }
}
