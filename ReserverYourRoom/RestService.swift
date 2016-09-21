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

class RestService: NSObject {
    
    static let sharedInstance = RestService()
    
    let baseURL = "http://localhost:8080/reserveyourroom/api"
    
    func getAllUsers(_ onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL+"/user"
        RestConnectionManager.sharedInstance.makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getAllRooms(_ onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL+"/room"
        RestConnectionManager.sharedInstance.makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }

}
