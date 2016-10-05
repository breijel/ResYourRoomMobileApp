//
//  WishDS.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 02/10/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import UIKit

class WishTableDelegateDataSource : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var wishes = [Wish]()
    
    var dataModel = DataModel.sharedInstance
    
    
    // Delegate
    
    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Abmelden") { action, index in
            print("Abmelden wish button tapped")
            
            let uuid: String = self.wishes[indexPath.row].uuid
            WishService.sharedInstance.delete(wishUuid: uuid)
            
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
    
    // Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wishes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWish") as! WishCell
        
        let wishElement = self.wishes[(indexPath as NSIndexPath).row]
        
        let roomUuid = wishElement.roomUuid
        cell.roomName.text = dataModel.rooms.filter({ (room) -> Bool in
            room.uuid == roomUuid
        })[0].name
        
        cell.startTime.text = wishElement.start
        cell.endTime.text = wishElement.end
        
        return cell
    }
    
}
