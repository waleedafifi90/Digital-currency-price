//
//  GeneralCollectionViewData.swift
//  Test2
//
//  Created by Mahmoud Abo-Osama on 11/19/19.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit

class GeneralCollectionViewData {
    
    var identifier: String!
    
    var cellSize: CGSize?
    
    var object: Any?
    
    init(identifier: String, object: Any?, cellSize: CGSize?) {
        self.identifier = identifier
        self.cellSize = cellSize
        self.object = object
    }
}
