//
//  Reservation.swift
//  ReserverYourRoom
//
//  Created by mattafix on 14.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation

struct Reservation {
    
    // MARK: Properties
    fileprivate let start : Date
    fileprivate let end : Date
    fileprivate let room : Room
    
    // MARK: Initialization
    init(room : Room, start : Date, end : Date){
        self.room = room
        self.start = start
        self.end = end
    }
}
