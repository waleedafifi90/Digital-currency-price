//
//  UIColorExtension.swift
//  UITableViewExample
//
//  Created by Waleed Afifi on 29/09/2019.
//  Copyright © 2019 Waleed Afifi. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    class func hexColor(hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy: 1)
//            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
            cString = String(cString.prefix(through: index))
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
