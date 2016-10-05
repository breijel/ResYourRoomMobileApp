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

class WishService: NSObject {
    
    static let sharedInstance = WishService()
    
    let baseURL = "http://localhost:8080/reserveyourroom/api"
    
    func getAll(_ onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL+"/wish"
        RestConnectionManager.sharedInstance.makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func delete(wishUuid: String){
        
        Alamofire
            .request("http://localhost:8080/reserveyourroom/api/wish/remove/" + wishUuid, method: .delete, parameters: [:])
            .responseString(completionHandler: { (response) in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
            })
    }
    
}
