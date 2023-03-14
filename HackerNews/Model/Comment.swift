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
        let readableText = text.stripOutHtml() ?? ""
        return readableText
    }
}

extension String {
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}
