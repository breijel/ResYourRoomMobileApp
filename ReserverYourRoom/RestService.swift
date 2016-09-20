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
    
    func getAllUsers() -> [User]{
        
        var users = [User]()
        
        let route = baseURL+"/user"
        RestConnectionManager.sharedInstance.makeHTTPGetRequest(route, onCompletion: { (json, err) in
            
            if let httpResponse = json.array {
                for entry in httpResponse {
                    let entryUser = User(json: entry)
                    users.append(entryUser)
                }
                print("in=\(users.count)")
            } else {
                print("error: could not parse json data")
            }
        })
        
        print("end=\(users.count)")
        return users
    }
}
