//
//  Room.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

struct Room{
    
    // MARK: Properties
    fileprivate let floor : Int
    fileprivate let size : Float
    fileprivate let seatnumber : Int
    fileprivate let name : String
    
    
    // MARK: Intitialization
    init(name: String, floor: Int, seatnumber: Int, size : Float) {
        self.name = name
        self.floor = floor
        self.seatnumber = seatnumber
        self.size = size
    }
}
