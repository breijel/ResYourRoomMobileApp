//
//  Reservation.swift
//  ReserverYourRoom
//
//  Created by mattafix on 14.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import SwiftyJSON

class Reservation {
    
    // MARK: Properties
    var uuid: String
    var start : Date
    var end : Date
    var roomUuid : String
    var userUuid: String
    
    // MARK: Initialization
    required init(json: JSON){
        self.uuid = json["uuid"].stringValue
        self.roomUuid = json["roomId"].stringValue
        self.start = Date(timeIntervalSince1970: TimeInterval(json["start"].intValue))
        self.end = Date(timeIntervalSince1970: TimeInterval(json["end"].intValue))
        self.userUuid = json["userId"].stringValue

    }
    
    func getJsonDictionary() -> [String: AnyObject] {
        
        print(self.end)
        
        let parameters: [String: AnyObject] = [
            "uuid": self.uuid as AnyObject,
            "roomId": self.roomUuid as AnyObject,
            "start": self.start as AnyObject,
            "end": self.end as AnyObject,
            "userId": self.uuid as AnyObject
        ]
        
        return parameters
    }
    
    
}

