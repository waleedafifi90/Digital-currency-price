//
//  BaseFile.swift
//  UITableViewExample
//
//  Created by Waleed Afifi on 20/10/2019.
//  Copyright © 2019 Waleed Afifi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum FileDataType: String {
    case image = "image/png"
    case video = "video/mp4"
    case audio = "audio/mp3"
}

class BaseFile {
    var data: Data?
    
    var name: String?
    
    var type: FileDataType = .image
    
    var fileName: String {
        switch type {
        case .image:
            return "\(self.name ?? "image").png"
        case .video:
            return "\(self.name ?? "video").mp4"
        case .audio:
            return "\(self.name ?? "audio").mp3"
        }
    }
}
