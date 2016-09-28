//
//  DataModel.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 28/09/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation

class DataModel {
    
    static let sharedInstance = DataModel()
    
    var rooms: [Room] = []
    var addresses: [String: Address] = [:]
    var infrastructures: [String: Infrastructure] = [:]
    var reservations: [String: Reservation] = [:]
    var wishes: [String: Wish] = [:]
    var buildings: [String: Building] = [:]
}
