//
//  StoryRow.swift
//  HackerNews
//
//  Created by Ben Gabay on 2/28/23.
//

import SwiftUI

struct StoryRow: View {
    
    let storyViewModel: StoryViewModel
    let index: Int
    
    var body: some View {
        HStack {
            rank
            VStack {
                headline
                subheadline
            }
        }
    }
    
    // "Rank"
    var rank: some View {
        Text(String(index))
            .font(.custom("Verdana", size: 12))
            .frame(width: 30)
            .foregroundColor(Color(uiColor: subheadlineGray))
            .padding(.trailing, 2)
            .padding(.leading, 8)
    }
    
    var headline: some View {
        HStack(alignment: .center) {
            Text(storyViewModel.story.title)
                .font(.custom("Verdana", size: 11))
                .foregroundColor(Color(.black))
                .multilineTextAlignment(.leading)
            Text(storyViewModel.story.readableURL)
                .font(.custom("Verdana", size: 9))
                .foregroundColor(Color(uiColor: subheadlineGray))
                .padding(.vertical, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var subheadline: some View {
        HStack {
            Text(storyViewModel.story.subheadline)
                .font(.custom("Verdana", size: 8))
                .foregroundColor(Color(uiColor: subheadlineGray))
                .padding(.trailing, -4)
            NavigationLink(destination: CommentView(storyViewModel: storyViewModel)) {
                Text(storyViewModel.story.commentsText)
                    .font(.custom("Verdana", size: 8))
                    .foregroundColor(Color(uiColor: subheadlineGray))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

let storyExample = Story(by: "TomFromMyspace",
                  id: 0,
                  score: 100,
                  time: 0,
                  title: "I love skateboarding and you should too",
                  type: .story,
                  url: "myspace.com",
                  descendants: 0,
                  kids: nil,
                  text: "some Text")
let storyExample1 = Story(by: "Rick Sanchez",
                  id: 0,
                  score: 242,
                  time: 0,
                  title: "Rick Sanchez has figured out time travel",
                  type: .story,
                  url: "rickandmorty.com",
                  descendants: 0,
                  kids: nil,
                  text: "some Text")
let storyExample2 = Story(by: "JohnnyStorm",
                  id: 0,
                  score: 1,
                  time: 0,
                  title: "Johnny Storm was denied a loan today",
                  type: .story,
                  url: "marvel.com",
                  descendants: 0,
                  kids: nil,
                  text: "some Text")

struct StoryRow_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            StoryRow(storyViewModel: StoryViewModel(story: storyExample1), index: 0)
            StoryRow(storyViewModel: StoryViewModel(story: storyExample2), index: 10)
            StoryRow(storyViewModel: StoryViewModel(story: storyExample), index: 124)
        }
    }
}
