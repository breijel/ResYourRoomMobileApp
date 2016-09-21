//
//  User.swift
//  ReserverYourRoom
//
//  Created by mattafix on 14.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import SwiftyJSON

class User {
    
    // MARK: Properties
    var uuid: String
    var firstname : String
    var lastname : String
    var email : String
    var whishes: [JSON]?
    var reservations: [JSON]?
    
    //private let wishes : [Wish]
    //private let reservations : [Reservation]
    
    required init(json:JSON){
        uuid = json["uuid"].stringValue
        firstname = json["firstname"].stringValue
        lastname = json["lastname"].stringValue
        email = json["email"].stringValue
        whishes = json["whishes"].array
        reservations = json["reservations"].array
    }
}
