//
//  FirstViewController.swift
//  ReserverYourRoom
//
//  Created by mattafix on 09.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tblRoomOverview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadRoomOverview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadRoomOverview() -> Void{
        //request webservcie for available rooms
    
       // var availableRooms = [String]
        
        //populate array --> availableRooms
        
        //tblRoomOverview.dataSource = availableRooms
        
        
    }
}

