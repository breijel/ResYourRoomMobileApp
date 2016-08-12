//
//  Adresse.swift
//  ReserverYourRoom
//
//  Created by mattafix on 12.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit

class Adresse{
    // MARK: Properties
    private var strasse : String
    private var strassenNummer : Int
    private var plz : Int
    private var ort : String
    private var land : String
    
    
    // MARK: Initialization
    init(strasse : String, strassenNummer : Int, ort : String, plz : Int, land : String){
        self.strasse = strasse
        self.strassenNummer = strassenNummer
        self.ort = ort
        self.plz = plz
        self.land = land
    }
}
