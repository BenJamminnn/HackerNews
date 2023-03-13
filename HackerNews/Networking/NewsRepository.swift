//
//  NewsRepository.swift
//  HackerNews
//
//  Created by Ben Gabay on 2/26/23.
//

import Foundation

protocol NewsServicable {
    func fetchTopStoryIds() async throws -> [Int]
    func getCommentsForStory(story: Story) async throws -> [Comment]
    func fetchStoriesAt(page: Int, batchSize: Int, stories: [Int]) async throws -> [Story]
    func getElementByIds<T: Codable>(ids: [Int]) async throws -> [T]
}

class HackerNewsRepository: NewsServicable {
    
    private let baseURLString = "https://hacker-news.firebaseio.com/v0"

    // Top Level Comments
    func getCommentsForStory(story: Story) async throws -> [Comment] {
        var comments = [Comment]()
        guard let commentIds = story.kids else { return [] }
        
        for id in commentIds {
            guard let commentURL = URL(string: baseURLString + "/item/\(id).json") else {
                throw FetchNewsError.badUrl
            }
            
            let (data, response) = try await URLSession.shared.data(from: commentURL)
            
            guard let responseCode = (response as? HTTPURLResponse)?.statusCode else { throw FetchNewsError.badDecode }
            guard responseCode == 200 else {
                throw FetchNewsError.badResponse(statusCode: responseCode)
            }
            do {
                let decodedComment = try JSONDecoder().decode(Comment.self, from: data)
                comments.append(decodedComment)
            } catch {
                throw FetchNewsError.badDecode
            }
        }
        
        return comments
    }
    
    // Used for getting child comments mainly
    func getElementByIds<T>(ids: [Int]) async throws -> [T] where T : Codable {
        guard ids.count > 0 else { return [] }
        
        var decodedElements = [T]()
        for id in ids {
            guard let url = URL(string: baseURLString + "/item/\(id).json") else {
                throw FetchNewsError.badUrl
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Make sure response is a response
            guard let responseCode = (response as? HTTPURLResponse)?.statusCode else { throw FetchNewsError.badDecode }
            guard responseCode == 200 else {
                throw FetchNewsError.badResponse(statusCode: responseCode)
            }
            
            do {
                let decodedElement = try JSONDecoder().decode(T.self, from: data)
                decodedElements.append(decodedElement)
            } catch {
                throw FetchNewsError.badDecode
            }
        }
        
        return decodedElements
    }
    
    // Fetch story ids, then fetch stories
    func fetchTopStoryIds() async throws -> [Int] {
        guard let url = URL(string: baseURLString + "/topstories.json") else {
            throw FetchNewsError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let responseCode = (response as? HTTPURLResponse)?.statusCode else { throw FetchNewsError.badDecode }
        guard responseCode == 200 else {
            throw FetchNewsError.badResponse(statusCode: responseCode)
        }

        do {
            return try JSONDecoder().decode([Int].self, from: data)
        } catch {
            throw FetchNewsError.badDecode
        }
    }
    
    // Paged story fetch
    func fetchStoriesAt(page: Int, batchSize: Int = 50, stories: [Int]) async throws -> [Story] {
        if stories.isEmpty || page < 0 || batchSize <= 0  { return [] }
        let startingIndex = page * batchSize
        let endingIndex: Int = {
            let endingIndex = startingIndex + batchSize
            let isOutOfBounds = stories.count - 1 <= endingIndex
            if isOutOfBounds {
                return stories.count - 1
            }

            return endingIndex
        }()
        
        if startingIndex > endingIndex { return [] }
        var pagedStories = [Story]()

        for i in startingIndex..<endingIndex {
            let storyId = stories[i]
            guard let itemURL =  URL(string: baseURLString + "/item/\(storyId).json") else {
                throw FetchNewsError.badUrl
            }
            
            let (data, response) = try await URLSession.shared.data(from: itemURL)
            
            guard let responseCode = (response as? HTTPURLResponse)?.statusCode else { throw FetchNewsError.badDecode }
            guard responseCode == 200 else {
                throw FetchNewsError.badResponse(statusCode: responseCode)
            }

            do {
                let decodedStory = try JSONDecoder().decode(Story.self, from: data)
                pagedStories.append(decodedStory)
            } catch {
                throw FetchNewsError.badDecode
            }
        }
        return pagedStories
    }
}
