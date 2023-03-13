//
//  CommentBox.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import SwiftUI

struct CommentBox: View {
    @ObservedObject var commentViewModel: CommentViewModel
    
    var body: some View {
        VStack {
            comment
            if !commentViewModel.isCollapsed {
                childrenComments
            }
        }
        .task {
            await commentViewModel.fetchChildComments()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(4)
    }
    
    @ViewBuilder
    var comment: some View {
        if let deleted = commentViewModel.comment.deleted {
            if deleted {
                deletedBody
            }
        } else {
            commentBody
                .padding(.vertical, 2)
        }
    }
    
    var commentBody: some View {
        VStack {
            HStack {
                Text(commentViewModel.comment.userHeadline)
                    .font(.custom("Verdana", size: 9))
                    .foregroundColor(Color(uiColor: subheadlineGray))
                    .frame(alignment: .leading)
                Spacer()
                Button {
                    commentViewModel.toggleCollapse()
                } label: {
                    Text(commentViewModel.minimizeStringValue)
                        .font(.custom("Verdana", size: 9))
                        .foregroundColor(Color(uiColor: subheadlineGray))
                        .frame(maxWidth: 50, alignment: .trailing)
                }
            }
            if !commentViewModel.isCollapsed {
                Text(commentViewModel.comment.readableText)
                    .font(.custom("Verdana", size: 13))
                    .foregroundColor(Color(.black))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
            }
        }
    }
    
    var deletedBody: some View {
        Text("[deleted]")
            .font(.custom("Verdana", size: 9))
            .foregroundColor(Color(uiColor: subheadlineGray))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 0.1)
    }
    
    var childrenComments: some View {
        VStack {
            ForEach(commentViewModel.childComments, id: \.self) { comment in
                CommentBox(commentViewModel: CommentViewModel(comment: comment))
            }
        }
        .padding(.leading, 8)
    }
}

struct CommentBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CommentBox(commentViewModel: CommentViewModel(comment: Comment(by: "Super user 12 12",
                                                                           id: 35016553,
                                                                           kids: nil,
                                                                           parent: 35015624,
                                                                           text: "Hello this is just an example",
                                                                           time: 1677887295,
                                                                           type: .comment,
                                                                           deleted: false
                                                                           )))
            CommentBox(commentViewModel: CommentViewModel(comment: Comment(by: "Super user 12 12",
                                                                           id: 35016553,
                                                                           kids: nil,
                                                                           parent: 35015624,
                                                                           text: "Hello this is just an example",
                                                                           time: 1677887295,
                                                                           type: .comment,
                                                                           deleted: true)))
            CommentBox(commentViewModel: CommentViewModel(comment: Comment(by: "Super user 12 12",
                                                                           id: 35016553,
                                                                           kids: [35016855],
                                                                           parent: 35015624,
                                                                           text: "This is a really long reply. I'm replying to a comment. I don't know what's going on. I am towlie. Progamming is cool, dude. These are just random thoughts",
                                                                           time: 1677887622,
                                                                           type: .comment,
                                                                           deleted: false)))
        }
    }
}
