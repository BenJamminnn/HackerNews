//
//  EntityType.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import Foundation

enum EntityType: String, Codable {
    case story = "story"
    case comment = "comment"
    case job = "job"
}
