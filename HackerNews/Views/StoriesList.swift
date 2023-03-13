//
//  StoriesList.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/8/23.
//

import SwiftUI

struct StoriesList: View {
    @ObservedObject var viewModel: HackerNewsViewModel
    var body: some View {
        VStack {
            scrollView
            if viewModel.state == .fetching {
                ProgressView()
            }
        }
    }
    
    var scrollView: some View {
        ScrollView {
            storiesList
        }
        .onScrolledToBottom {
            Task {
                await viewModel.fetchNextPage()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 8)
        .refreshable {
            await viewModel.refreshStories()
        }
    }
    
    var storiesList: some View {
        VStack {
            ForEach(Array(viewModel.topStories.enumerated()), id: \.element) { index, element in
                NavigationLink(destination: storyDestination(story: element)) {
                    StoryRow(storyViewModel: StoryViewModel(story: element), index: index + 1) // account for 0
                }
            }
        }
    }

    @ViewBuilder
    func storyDestination(story: Story) -> some View {
        if story.url != nil {
            WebView(webViewModel: WebViewModel(story: story))
        } else {
            CommentView(storyViewModel: StoryViewModel(story: story))
        }
    }
}

struct StoriesList_Previews: PreviewProvider {
    static var previews: some View {
        StoriesList(viewModel: HackerNewsViewModel())
    }
}
