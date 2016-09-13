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
    
    // MARK: Initialization
    /*init(firstname : String, lastname : String, email : String, wishes : [Wish], reservations : [Reservation]){
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.wishes = wishes
        self.reservations = reservations
    }*/
    
    required init(json:JSON){
        uuid = json["uuid"].stringValue
        firstname = json["firstname"].stringValue
        lastname = json["lastname"].stringValue
        email = json["email"].stringValue
        whishes = json["whishes"].array
        reservations = json["reservations"].array
    }
}
