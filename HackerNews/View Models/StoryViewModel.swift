//
//  StoryViewModel.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import UIKit

/*
 TODO:
 - Threading issues
 - Implement sorting, search?
 - FIX REFRESH
 - Comment View - show loading indicator
 - Fix Links in comments
 - [Done] loading indicator for comments
 - [Done] why 2 loading vars in stories list?
 - [Done] Deal with error states
 - [Done] Fix extra padding around comments
 - [Done] Enable paging on stories
 - [Done] why dont top stories correlate with frontend (paging issue)
 - [Done] Initial loading screen is off
 - [Done] Fix subheadline issue
 */


enum CommentState {
    case loaded
    case isLoading
    case error(errorMessage: String)
}

class StoryViewModel: ObservableObject {
    private let service = HackerNewsRepository()
    
    @Published var topLevelComments = [Comment]()
    @Published var state: CommentState = .isLoading

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
