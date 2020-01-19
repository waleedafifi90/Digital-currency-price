//
//  New.swift
//  coin
//
//  Created by Waleed Afifi on 13/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import Foundation

struct News: Codable {
    let pkIID: Int
    let sTitle: String
    let sImage: String
    let sDescription: String
    let bEnabled: Bool
    let dtCreatedDate, dtModifiedDate: String
}
