//
//  RestService.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 20/09/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ReservationService: NSObject {
    
    static let sharedInstance = ReservationService()
    
    let baseURL = "http://localhost:8080/reserveyourroom/api"
    
    func getAll(_ onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL+"/reservation"
        RestConnectionManager.sharedInstance.makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func removeReservation(_ onCompletion: @escaping (JSON) -> Void, reservation: Reservation) {
        let dictionary = [String: AnyObject]()
        let route = baseURL+"/reservation/"+reservation.uuid
        RestConnectionManager.sharedInstance.makeHTTPPostRequest(route, body: dictionary, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
}
