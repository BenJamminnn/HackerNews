//
//  FetchNewsError.swift
//  HackerNews
//
//  Created by Ben Gabay on 3/3/23.
//

import Foundation

enum FetchNewsError: Error {
    case badUrl
    case badResponse(statusCode: Int)
    case badDecode
    case topStoriesEmpty
    
    var description: String {
        switch self {
        case .badUrl:
            return "The given url could not be resolved"
        case .badResponse(let statusCode):
            return "Request Failed with status code: \(statusCode)"
        case .badDecode:
            return "Response body could not be decoded"
        case .topStoriesEmpty:
            return "Top News Ids not populated"
        }
    }
}
