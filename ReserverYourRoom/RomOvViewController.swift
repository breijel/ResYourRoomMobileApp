//
//  FirstViewController.swift
//  ReserverYourRoom
//
//  Created by mattafix on 09.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit

class RomOvViewController: UIViewController, UITableViewDelegate {

    // MARK: properties
    @IBOutlet weak var tableRoomOverview: UITableView!
    var arrBuilding = [Building]()
    var numberOfRooms : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadSampleRooms()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: table roomoverview stuff
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        for building in arrBuilding{
            numberOfRooms += building.getNumberOfRooms()
        }
        
        return numberOfRooms
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellRoom")
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    func loadSampleRooms(){
        
        var arrRoom = [Room]()
        
        for bldIdx in 1...5 {
            for romIdx in 1...10{
                arrRoom.append(Room(name: "Room_\(romIdx)", floor: romIdx, seatnumber: (romIdx*2), size: 50))
            }
            
            let address = Address(street: "Hauptstrasse_\(bldIdx)", housenumber: String(bldIdx), city: "Bern", zipcode: "ZipCode", country: "Contry", state: "State")
            
            let building = Building(name: "Gebäude_\(bldIdx)", address: address, rooms: arrRoom)
            
            arrBuilding.append(building)
            
        }
        
        
        
    }
}

