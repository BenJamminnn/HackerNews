//
//  Story.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import Foundation

struct Story: Codable, Hashable, Equatable {
    let by: String
    let id: Int
    let score: Int
    let time: Int
    let title: String
    let type: EntityType
    let url: String?
    let descendants: Int?
    let kids: [Int]?
    let text: String?
    
    var readableURL: String {
        guard let urlString = url else { return "" }
        let url: URL? = URL(string: urlString)
        if let readableHost = url?.host {
            return "(\(readableHost))"
        }
        return ""
    }
    
    var commentsText: String {
        if let descendants {
            let comment = descendants == 1 ? "comment" : "comments"
            return "| \(descendants) " + comment
        }
        return "| 0 comments"
    }
    
    var subheadline: String {
        return "\(score) points by \(by) \(DateHelper.timeToReadableTime(time))"
    }
}
