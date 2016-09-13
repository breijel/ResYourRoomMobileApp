//
//  RestApiManager.swift
//  ReserverYourRoom
//
//  Created by Philippe Wanner on 13/09/16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestConnectionManager: NSObject {
    static let sharedInstance = RestConnectionManager()
    
    let baseURL = "http://localhost:8080/reserveyourroom/api"
    
    // MARK: Perform a GET Request
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(nil, error)
            }
        })
        task.resume()
    }
    
    // MARK: Perform a POST Request
    private func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
        do {
            // Set the POST body for the request
            let jsonBody = try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
            request.HTTPBody = jsonBody
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error)
                }
            })
            task.resume()
        } catch {
            // Create your personal error
            onCompletion(nil, nil)
        }
    }
    
    func getAllUsers(onCompletion: (JSON) -> Void) {
        let route = baseURL+"/user"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
}