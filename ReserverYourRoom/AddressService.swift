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

class AddressService: NSObject {
    
    static let sharedInstance = AddressService()
    
    let baseURL = "http://localhost:8080/reserveyourroom/api"
    
    func getAll(_ onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL+"/address"
        RestConnectionManager.sharedInstance.makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
}
