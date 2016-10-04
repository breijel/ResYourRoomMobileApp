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
import Alamofire

class ReservationService: NSObject {
    
    static let sharedInstance = ReservationService()
    
    static let baseURL = "http://localhost:8080/reserveyourroom/api"
    static let endpoint = baseURL + "/reservation"
    
    func getAll(_ onCompletion: @escaping (JSON) -> Void) {
        RestConnectionManager.sharedInstance.makeHTTPGetRequest(ReservationService.endpoint, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func removeReservation(_ onCompletion: @escaping (JSON) -> Void, reservation: Reservation) {
        let postItems:[String: AnyObject] = ["uuid": reservation.uuid as AnyObject]
        RestConnectionManager.sharedInstance.makeHTTPPostRequest(ReservationService.endpoint, body: postItems, onCompletion: { json, err in
            onCompletion(json as JSON)
            print("response: ",json)
        })
    }
    
    func delete(reservationUuid: String){
        
        Alamofire
            .request("http://localhost:8080/reserveyourroom/api/reservation/remove/" + reservationUuid, method: .delete, parameters: [:])
            .responseString(completionHandler: { (response) in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                print(response.result.error)
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            })
    }
    
    func save(reservation: Reservation){
        
        Alamofire
            .request("http://localhost:8080/reserveyourroom/api/reservation/", method: .post, parameters: reservation.getJsonDictionary())
            .responseString(completionHandler: { (response) in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                print(response.result.error)
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            })
    }

}
