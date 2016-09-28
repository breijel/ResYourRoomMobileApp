//
//  Wish.swift
//  ReserverYourRoom
//
//  Created by mattafix on 14.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import SwiftyJSON

class Wish {
    
    // MARK: Properties
    var uuid: String
    //var start : String
    //var end : String
    //var roomUuid : String
    //var userUuid : String
    
    // MARK: Initialization
    required init(json: JSON){
        self.uuid = json["uuid"].stringValue
        /*self.start = json["start"].stringValue
        self.end = json["end"].stringValue
        self.roomUuid = json["roomId"].stringValue
        self.userUuid = json["userId"].stringValue*/
    }
}
