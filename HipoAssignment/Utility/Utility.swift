//
//  Utility.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 1.03.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject {
    class func convertFormat(_ unformattedDate: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "tr_TR") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var dateString = ""
        if let date = dateFormatter.date(from: unformattedDate) {
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateFormatter.locale = tempLocale // reset the locale
            dateString = dateFormatter.string(from: date)

            return dateString
        }
        return dateString
    }
}
