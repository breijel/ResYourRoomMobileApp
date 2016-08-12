//
//  Gebaeude.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit

class Gebaeude{
    // MARK: Properties
    private var adresse : Adresse
    private var raeume : [Raum]
    
    // MARK: Initialization
    init(adresse : Adresse, raeume : [Raum]){
        self.adresse = adresse
        self.raeume = raeume
    }
}
