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
    var reservation: Reservation?
    var wish: Wish?
    var building: Building?
    var address: Address?
    
    required init(room: Room){
        //, address: Address, infrastructure: Infrastructure, reservation: Reservation, wish: Wish, building: Building){
        self.room = room
        /*self.infrastructure = infrastructure
        self.reservation = reservation
        self.wish = wish
        self.building = building
        self.address = address*/
    }
}
