//
//  Gebaeude.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import SwiftyJSON

class Building{
    
    // MARK: Properties
    var uuid: String
    var addressUuid : String
    var name : String
    
    // MARK: Initialization
    required init(json: JSON){
        self.uuid = json["uuid"].stringValue
        self.addressUuid = json["addressId"].stringValue
        self.name = json["name"].stringValue
    }
}
