//
//  Room.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit

class Raum{
    // MARK: Properties
    private var stockwerk : Int
    private var groesse : Float
    private var anzSitzplatz : Int
    private var raumName : String
    
    
    // MARK: Intitialization
    init(raumName: String, stockwerk: Int, anzSitzplatz: Int, groesse : Float) {
        self.raumName = raumName
        self.stockwerk = stockwerk
        self.anzSitzplatz = anzSitzplatz
        self.groesse = groesse
    }
}
