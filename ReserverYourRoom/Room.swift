//
//  Room.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import SwiftyJSON

class Room {
    
    // MARK: Properties
    var uuid: String
    var floor : Int
    var size : Float
    var seatnumber : Int
    var name: String
    
    //private let wishes : [Wish]
    //private let reservations : [Reservation]
    
    required init(json:JSON){
        uuid = json["uuid"].stringValue
        floor = json["floor"].intValue
        size = json["size"].floatValue
        seatnumber = json["seatnumber"].intValue
        name = json["name"].stringValue
    }
}
