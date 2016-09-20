//
//  Gebaeude.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation

class Building{
    
    // MARK: Properties
    fileprivate let address : Address
    fileprivate let rooms : [Room]
    fileprivate let name : String
    
    // MARK: Initialization
    init(name : String, address : Address, rooms : [Room]){
        self.address = address
        self.rooms = rooms
        self.name = name
    }
    
    func getNumberOfRooms() -> Int {
        return self.rooms.count
    }
}
