//
//  User.swift
//  ReserverYourRoom
//
//  Created by mattafix on 14.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation

struct User {
    
    // MARK: Properties
    private let firstname : String
    private let lastname : String
    private let email : String
    private let wishes : [Wish]
    private let reservations : [Reservation]
    
    // MARK: Initialization
    init(firstname : String, lastname : String, email : String, wishes : [Wish], reservations : [Reservation]){
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.wishes = wishes
        self.reservations = reservations
    }
}
