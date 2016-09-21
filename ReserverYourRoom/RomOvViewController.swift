//
//  FirstViewController.swift
//  ReserverYourRoom
//
//  Created by mattafix on 09.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit
import SwiftyJSON

class RomOvViewController: UIViewController, UITableViewDelegate {
    
    // MARK: properties
    @IBOutlet weak var tableRoomOverview: UITableView!
    var arrBuilding = [Building]()
    var numberOfRooms : Int = 0
    var rooms = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        RestService.sharedInstance.getAllRooms{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryRoom = Room(json: entry)
                    self.rooms.append(entryRoom)
                }
                
                self.tableRoomOverview.reloadData()
                DispatchQueue.main.async {
                    self.tableRoomOverview.reloadData()
                }
            } else {
                print("error: could not parse json data")
            }
            print("rooms count = \(self.rooms.count)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: table roomoverview stuff
    /*func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
     
     for building in arrBuilding{
     numberOfRooms += building.getNumberOfRooms()
     }
     
     return numberOfRooms
     }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellRoom")
        
        //cell.textLabel?.text = "test"
        
        //return cell
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellRoom")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellRoom")
        }
        
        let room = self.rooms[(indexPath as NSIndexPath).row]
        
        cell!.textLabel?.text = room.name
        return cell!
    }
}

