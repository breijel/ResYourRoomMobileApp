//
//  RoomDetail.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 27/09/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation

class RoomDetail {
    
    var room: Room?
    var infrastructure: Infrastructure?
    var building: Building?
    var address: Address?
    
    required init(room: Room, address: Address, building: Building, infrastructure: Infrastructure){
        self.room = room
        self.infrastructure = infrastructure
        self.building = building
        self.address = address
    }
}
