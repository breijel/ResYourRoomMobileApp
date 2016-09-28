//
//  Infrastructure.swift
//  ReserverYourRoom
//
//  Created by mattafix on 14.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import SwiftyJSON

class Infrastructure {
    
    // MARK: Properties
    var uuid: String
    var name: String
    var roomUuid: String
    
    // MARK: Initialization
    required init(json: JSON){
        uuid = json["uuid"].stringValue
        name = json["name"].stringValue
        roomUuid = json["roomId"].stringValue
    }
}
