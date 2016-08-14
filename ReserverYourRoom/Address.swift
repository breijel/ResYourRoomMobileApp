//
//  Adresse.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

struct Address{
    
    // MARK: Properties
    private let street : String
    private let housenumber : String
    private let zipcode : String
    private let city : String
    private let state : String
    private let country : String
    
    
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
