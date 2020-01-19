//
//  Favourite.swift
//  coin
//
//  Created by Waleed Afifi on 12/01/2020.
//  Copyright © 2020 Waleed Afifi. All rights reserved.
//

import Foundation

struct Favourite: Codable {
    let pkIID: Int
    let sCode, sName: String
    let dValue, dTrading: Float
    let sIcon: String
    let bEnabled: Bool
    let dtCreatedDate, dtModifiedDate: String
}
