//
//  StoryViewModel.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import UIKit
import Observation

enum CommentState {
    case loaded
    case isLoading
    case error(errorMessage: String)
}

@Observable
class StoryViewModel {
    private let service = HackerNewsRepository()
    
    var topLevelComments = [Comment]()
    var state: CommentState = .isLoading

    let story: Story
    
    init(story: Story) {
        self.story = story
    }
    
    /// Fetching Top Level comments for a Story
    func fetchComments() async {
        await MainActor.run {
            state = .isLoading
        }
    
        do {
            let commentsForStory = try await service.getCommentsForStory(story: story)
            await MainActor.run {
                self.state = .loaded
                self.topLevelComments = commentsForStory
            }
        } catch {
            await MainActor.run {
                let errorString = (error as? FetchNewsError)?.description ?? "Error Found!\n\(error.localizedDescription)"
                state = .error(errorMessage: errorString)
            }
        }
    }
}
