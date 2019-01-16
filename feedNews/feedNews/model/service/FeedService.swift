//
//  FeedService.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 16/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import Foundation
import Alamofire

class FeedService {
    
    var responseObject: ServiceObject?
    let URL_API = "https://s3.glbimg.com/v1/AUTH_0a546877ae934340a12a639673da6690/010bf5/challenge/news/api/content.json"
    
    func getFeedNews(completion: @escaping() -> Void) -> Void {
        
        let urlRequest = "\(URL_API)"
        var headers = Dictionary<String, String>()
        headers.updateValue("application/json", forKey: "Content-Type")
        
        Alamofire.request(urlRequest, headers:headers)
            .validate(statusCode: 200..<300)
            .responseJSON{(response) -> Void in
               
                self.responseObject = ServiceObject()
               
                switch response.result {
                case .success:
                    let json = response.result.value
                    self.responseObject!.jsonObject = json as AnyObject?
                    if let data = response.data {
                        self.responseObject!.data = data
                    }
                case .failure(let error):
                    self.responseObject!.error = error as NSError
                    if let data = response.data {
                        self.responseObject!.jsonObject = data as AnyObject
                        self.responseObject!.data = data
                    }
                }
                completion()
        }
    }
}
