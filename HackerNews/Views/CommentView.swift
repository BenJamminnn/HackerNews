//
//  CommentView.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import SwiftUI

struct CommentView: View {
    
    @ObservedObject var storyViewModel: StoryViewModel

    var body: some View {
        VStack {
            switch storyViewModel.state {
            case .loaded:
                comments
            case .isLoading:
                textBody
                LoadingView()
            case .error(let errorMessage):
                textBody
                ErrorStateView(errorMessage: errorMessage) {
                    Task {
                        await storyViewModel.fetchComments()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarTitle(storyViewModel.story.title, displayMode: .inline)
        .toolbarBackground(hackerNewsOrangeColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(hackerNewsBgColor)
        .task {
            await storyViewModel.fetchComments()
        }
    }
    
    @ViewBuilder
    var textBody: some View {
        if storyViewModel.story.text != nil {
            VStack {
                Text(storyViewModel.story.text ?? "")
                    .font(.custom("Verdana", size: 10))
                    .foregroundColor(Color(.black))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
            }
            .padding(12)
        }
        EmptyView()
    }
    
    var comments: some View {
        ScrollView {
            textBody
            ForEach(storyViewModel.topLevelComments, id: \.self) { comment in
                CommentBox(commentViewModel: CommentViewModel(comment: comment))
            }
        }
    }
}

let storyVMExample = Story(by: "JohnnyStorm",
                  id: 0,
                  score: 1,
                  time: 0,
                  title: "Johnny Storm was denied a loan today",
                  type: .story,
                  url: "marvel.com",
                  descendants: 0,
                  kids: [],
                  text: "some Text")
let commentsExample = [
    Comment(by: "Example User",
            id: 35016553,
            kids: nil,
            parent: 35015624,
            text: "Hello this is just an example",
            time: 1677887295,
            type: .comment,
            deleted: false),
    Comment(by: "Super user 12 12",
            id: 35016553,
            kids: [35016855],
            parent: 35015624,
            text: "This is a really long reply. I'm replying to a comment. I don't know what's going on. I am towlie. Progamming is cool, dude. These are just random thoughts",
            time: 1677887622,
            type: .comment,
            deleted: false),
    Comment(by: "BatmanIsCool",
            id: 35017083,
            kids: nil,
            parent: 35015624,
            text: "Only tangentially related, but reminds me of something I ran across recently.  I&#x27;ve been maintaining a couple of old blogs my wife used to write for years; I don&#x27;t want to get rid of them, but it was a bit of a pain having to regularly keep wordpress updated and fix any related issues.  Recently found a WP plugin, Simply Static, that will generate a static site from a wordpress blog, maintaining all the URLs and such.  So it&#x27;s perfect for my use case of archiving something that won&#x27;t be added to in the future. But you can also use it for a live site, just exporting a new static version after each post.<p>Used it for those couple of blogs with zero issues, and now I can keep the originals around but inaccessible from the internet, so I don&#x27;t have to worry about keeping them updated, aside from when I update php itself.",
            time: 1677891954,
            type: .comment,
            deleted: false)
]

let dummyModel: StoryViewModel = {
    let storyViewModel = StoryViewModel(story: storyVMExample)
    storyViewModel.topLevelComments = commentsExample
    return storyViewModel
}()

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(storyViewModel: StoryViewModel(story: storyVMExample))
    }
}
