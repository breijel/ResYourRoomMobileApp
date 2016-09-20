//
//  Adresse.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

struct Address{
    
    // MARK: Properties
    fileprivate let street : String
    fileprivate let housenumber : String
    fileprivate let zipcode : String
    fileprivate let city : String
    fileprivate let state : String
    fileprivate let country : String
    
    
    // MARK: Initialization
    init(street : String, housenumber : String, city : String, zipcode : String, country : String, state : String){
        self.street = street
        self.housenumber = housenumber
        self.city = city
        self.zipcode = zipcode
        self.country = country
        self.state = state
    }
}
