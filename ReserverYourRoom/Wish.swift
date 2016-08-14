//
//  Wish.swift
//  ReserverYourRoom
//
//  Created by mattafix on 14.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation

struct Wish {
    
    // MARK: Properties
    private let start : NSDate
    private let end : NSDate
    private let infrastructure : [Infrastructure]
    private let address : Address
    private let building : Building
    private let room : Room
    
    // MARK: Initialization
    init(start : NSDate, end : NSDate, infrastructure : [Infrastructure], address : Address, building : Building, room : Room){
        self.start = start
        self.end = end
        self.infrastructure = infrastructure
        self.address = address
        self.building = building
        self.room = room
    }
}
