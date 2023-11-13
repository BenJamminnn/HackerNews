//
//  CommentViewModel.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import UIKit

@Observable
class CommentViewModel {
    private let service = HackerNewsRepository()

    var childComments = [Comment]()
    var isCollapsed = false
    var errorStateString: String?

    let comment: Comment
    
    var minimizeStringValue: String {
        let amount = String(comment.kids?.count ?? 0)
        return isCollapsed ? "[ \(amount)" + " more" + " ]"  : "[-]"
    }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func toggleCollapse() {
        isCollapsed.toggle()
    }
    
    func fetchChildComments() async {
        if let commentIds = comment.kids {
            do {
                let children: [Comment] = try await service.getElementByIds(ids: commentIds)
                await MainActor.run {
                    self.childComments = children
                }
            } catch {
                await MainActor.run {
                    errorStateString = (error as? FetchNewsError)?.description ?? "Error Found!\n\(error.localizedDescription)"
                }
            }
        }
    }
}
