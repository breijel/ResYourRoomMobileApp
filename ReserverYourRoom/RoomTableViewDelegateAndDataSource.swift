//
//  RoomTableViewDelegateAndDataSource.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 02/10/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class RoomTableDelegateDataSource : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var result = [RoomDetail]()
    
    var dataModel = DataModel.sharedInstance
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRoom") as! RoomViewCell
        
        let roomDetail = self.result[(indexPath as NSIndexPath).row]
        
        cell.roomname.text = roomDetail.room?.name
        cell.location.text = roomDetail.address?.city
        cell.infrastructure.text = roomDetail.infrastructure?.name
        cell.address.text = roomDetail.address?.street
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let reservation = UITableViewRowAction(style: .normal, title: "Reservation") { action, index in
            print("Reservation button tapped")
            let roomUuid: String = self.result[indexPath.row].room!.uuid
            
            let reservationUuid = self.dataModel.reservations.filter({ (
                id, reservation) -> Bool in
                reservation.roomUuid == roomUuid
            })[0].value.uuid
            
            let reservation = self.dataModel.reservations[reservationUuid]

            ReservationService.sharedInstance.save(reservation: reservation!)
        }
        reservation.backgroundColor = UIColor.blue
        
        let wish = UITableViewRowAction(style: .normal, title: "Wish") { action, index in
            print("Wish button tapped")
        }
        wish.backgroundColor = UIColor.orange
        
        return [reservation, wish]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
        
    }

}
