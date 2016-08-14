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
    private let start : NSDate
    private let end : NSDate
    private let room : Room
    
    // MARK: Initialization
    init(room : Room, start : NSDate, end : NSDate){
        self.room = room
        self.start = start
        self.end = end
    }
}
