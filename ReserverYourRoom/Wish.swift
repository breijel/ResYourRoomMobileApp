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
    fileprivate let start : Date
    fileprivate let end : Date
    fileprivate let infrastructure : [Infrastructure]
    fileprivate let address : Address
    fileprivate let building : Building
    fileprivate let room : Room
    
    // MARK: Initialization
    init(start : Date, end : Date, infrastructure : [Infrastructure], address : Address, building : Building, room : Room){
        self.start = start
        self.end = end
        self.infrastructure = infrastructure
        self.address = address
        self.building = building
        self.room = room
    }
}
