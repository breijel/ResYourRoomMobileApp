//
//  Adresse.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import SwiftyJSON

class Address{
    
    // MARK: Properties
    var uuid: String
    var street : String
    var zipcode : String
    var city : String
    var state: String
    var country : String

    
    required init(json:JSON){
        uuid = json["uuid"].stringValue
        street = json["street"].stringValue
        zipcode = json["zipcode"].stringValue
        city = json["city"].stringValue
        state = json["state"].stringValue
        country = json["country"].stringValue
    }
}
