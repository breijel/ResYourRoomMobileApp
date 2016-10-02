//
//  ReservationDelegate.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 02/10/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ReservationTableDelegateDataSource : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var reservations = [Reservation]()
    
    var dataModel = DataModel.sharedInstance
    
    
    // Delegate
    
    private func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Abmelden") { action, index in
            print("Abmelden reservation button tapped")
           /*
            ReservationService.sharedInstance.removeReservation({ (json: JSON) in
                if let results = json.array {
                    for entry in results {
                        print(entry)
                    }
                } else {
                    print("error: could not parse json data remove reservation")
                }}, reservation: self.reservations[0])
        */
        }
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction]
    }
    
    private func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    private func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
        
    }
    
    // Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reservations.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
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
    
}
