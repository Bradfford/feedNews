//
//  FeedNews.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 16/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import Foundation


class FeedNews: Codable {
    
    let status : String?
    let totalResults : Int64?
    let articles : [Articles]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}
