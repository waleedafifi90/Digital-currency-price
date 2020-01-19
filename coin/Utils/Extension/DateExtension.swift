//
//  DateExtension.swift
//  UITableViewExample
//
//  Created by Waleed Afifi on 27/10/2019.
//  Copyright © 2019 Waleed Afifi. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

extension Date {
    
    func dateToString(customFormat: String, timeZone: String = "UTC", local: String = "en") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: local)
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.init(identifier: timeZone)
        dateFormatter.dateFormat = customFormat
        return dateFormatter.string(from: self)
    }
    
    
}
