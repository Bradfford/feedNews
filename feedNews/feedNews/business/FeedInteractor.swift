//
//  FeedInteractor.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 16/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case parseError
    case requestError
}

class FeedInteractor {
    
    let feedService = FeedService()
    
    func getFeedNews(successCompletion: @escaping(_ feedNews: FeedNews) -> Void, errorCompletion: @escaping(_ error: ServiceError) -> Void) -> Void {
        
        self.feedService.getFeedNews(completion:{
            if let serviceResponse = self.feedService.responseObject, let _ = serviceResponse.jsonObject, let jsonObjectResponseData = serviceResponse.data {
                if let _ = serviceResponse.error {
                    errorCompletion(.requestError)
                } else {
                    do {
                        let feedNews = try JSONDecoder().decode(FeedNews.self, from: jsonObjectResponseData)
                        successCompletion(feedNews)
                    } catch {
                        errorCompletion(.parseError)
                    }
                }
            
            } else {
                errorCompletion(.requestError)
            }
        })
    }
}
