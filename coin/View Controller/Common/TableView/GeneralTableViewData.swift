//
//  GeneralTableViewData.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 11/10/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit

class GeneralTableViewData {
    
    var identifier: String!
    
    var rowHeight: CGFloat?
    
    var object: Any?
    
    init(identifier: String, object: Any?, rowHeight: CGFloat?) {
        self.identifier = identifier
        self.rowHeight = rowHeight
        self.object = object
    }
}
