//
//  Helper.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/29/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import UIKit

extension String {
    
    //"yyyy-MM-dd'T'HH:mm:ss'Z'"
    func handleDate() -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        let splitString = dateString.components(separatedBy: " ")
        return splitString[0]
    }
    
}
