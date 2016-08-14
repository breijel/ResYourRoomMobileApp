//
//  Room.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

struct Room{
    
    // MARK: Properties
    private let floor : Int
    private let size : Float
    private let seatnumber : Int
    private let name : String
    
    
    // MARK: Intitialization
    init(name: String, floor: Int, seatnumber: Int, size : Float) {
        self.name = name
        self.floor = floor
        self.seatnumber = seatnumber
        self.size = size
    }
}
