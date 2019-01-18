//
//  Formatter.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 18/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import Foundation

class Formatter {
    
    func dateFormatter(dateToFormat: String?) -> String{
        
        if let formatDate = dateToFormat, formatDate != ""{
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: formatDate){
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                dateFormatter.locale = tempLocale
                return dateFormatter.string(from: date)
            }
        }
        return "N/A"
    }
}
