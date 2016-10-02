//
//  ThirdViewController.swift
//  ReserverYourRoom
//
//  Created by mattafix on 09.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResOvViewController : UIViewController {
    
    @IBOutlet weak var wishTableView: UITableView!
    @IBOutlet weak var reservationTableView: UITableView!
    // MARK: property
    let reservationTableDelegateAndDS = ReservationTableDelegateDataSource()
    let wishTableDelegateAndDS = WishTableDelegateDataSource()
    
    override func viewDidLoad() {
        
        reservationTableView.delegate = self.reservationTableDelegateAndDS
        reservationTableView.dataSource = self.reservationTableDelegateAndDS
        
        wishTableView.delegate = self.wishTableDelegateAndDS
        wishTableView.dataSource = self.wishTableDelegateAndDS
        
        ReservationService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entry = Reservation(json: entry)
                    self.reservationTableDelegateAndDS.reservations.append(entry)
                }
                DispatchQueue.main.async {
                    self.reservationTableView.reloadData()
                    print("reservations count = \(self.reservationTableDelegateAndDS.reservations.count)")
                }
            } else {
                print("error: could not parse json data reservation")
            }
        }
        
        WishService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entry = Wish(json: entry)
                    self.wishTableDelegateAndDS.wishes.append(entry)
                }
                DispatchQueue.main.async {
                    self.wishTableView.reloadData()
                    print("wishes count = \(self.wishTableDelegateAndDS.wishes.count)")
                }
            } else {
                print("error: could not parse json data wish")
            }
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
