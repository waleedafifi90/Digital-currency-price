//
//  UITabBarExtension.swift
//  UITableViewExample
//
//  Created by Waleed Afifi on 19/09/2019.
//  Copyright © 2019 Waleed Afifi. All rights reserved.
//

import Foundation
import UIKit

extension UITabBar {
    
    @IBInspectable  var isShowOriginalImage: Bool {
        set {
            for (index, item) in (self.items ?? []).enumerated() {
                let img = item.selectedImage?.withRenderingMode(.alwaysOriginal)
                self.items?[index].selectedImage = newValue == true ? img : item.selectedImage
            }
        } get {
            return false
        }
    }
    
    @IBInspectable var noneSelectedImage: UIColor {
        set {
            self.unselectedItemTintColor = newValue
        } get {
            return self.unselectedItemTintColor ?? .gray
        }
    }
}
