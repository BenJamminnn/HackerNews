//
//  Comment.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import Foundation

struct Comment: Codable, Hashable {
    let by: String?
    let id: Int
    let kids: [Int]?
    let parent: Int
    let text: String?
    let time: Int
    let type: EntityType
    let deleted: Bool?
    
    var userHeadline: String {
        return "by \(by ?? "[deleted]") \(DateHelper.timeToReadableTime(time))"
    }
    
    var readableText: String {
        guard let text else { return "" }
        let apostrophe = "&#x27;"
        let forwardSlash = "&#x2F;"
        let aTag = "<a href="
        let aTagEnd = "</a>"
        let pTag = "<p>"
        let italicsTagStart = "<i>"
        let italicsTagEnd = "</i>"
        let forwardCarrot = "&gt;"
        let quote = "&quot;"
        let readableText = text
            .replacingOccurrences(of: apostrophe, with: "'")
            .replacingOccurrences(of: forwardSlash, with: "/")
            .replacingOccurrences(of: aTag, with: "")
            .replacingOccurrences(of: aTagEnd, with: "")
            .replacingOccurrences(of: pTag, with: "")
            .replacingOccurrences(of: italicsTagStart, with: "*")
            .replacingOccurrences(of: italicsTagEnd, with: "*")
            .replacingOccurrences(of: forwardCarrot, with: ">")
            .replacingOccurrences(of: quote, with: "\"")
        return readableText
    }
}
