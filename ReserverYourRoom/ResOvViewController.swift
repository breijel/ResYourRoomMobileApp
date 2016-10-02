//
//  ThirdViewController.swift
//  ReserverYourRoom
//
//  Created by mattafix on 09.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResOvViewController : UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var reservationTableView: UITableView!
    // MARK: property
    @IBOutlet weak var wishTableView: UITableView!
    
    var reservations = [Reservation]()
    
    var dataModel = DataModel.sharedInstance
    
    override func viewDidLoad() {
        
        ReservationService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entry = Reservation(json: entry)
                    self.reservations.append(entry)
                }
                DispatchQueue.main.async {
                    self.reservationTableView.reloadData()
                    print("reservations count = \(self.reservations.count)")
                }
            } else {
                print("error: could not parse json data reservation")
            }
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reservations.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReservation") as! ReservationCell
        
        let reservaationElement = self.reservations[(indexPath as NSIndexPath).row]
        
        let roomUuid = reservaationElement.roomUuid
        cell.roomName.text = dataModel.rooms.filter({ (room) -> Bool in
            room.uuid == roomUuid
        })[0].name
        
        cell.startTime.text = reservaationElement.start
        cell.endTime.text = reservaationElement.end
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Abmelden") { action, index in
            print("Abmelden reservation button tapped")
        }
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
        
    }

}
