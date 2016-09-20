//
//  FirstViewController.swift
//  ReserverYourRoom
//
//  Created by mattafix on 09.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit
import SwiftyJSON

class RomOvViewController: UIViewController, UITableViewDelegate {

    // MARK: properties
    @IBOutlet weak var tableRoomOverview: UITableView!
    var arrBuilding = [Building]()
    var numberOfRooms : Int = 0
    var users = [User]()
    
    fileprivate func addUserData(){
        RestConnectionManager.sharedInstance.getAllUsers { (json: JSON) in
            if let results = json.array {
                for entry in results {
                    self.users.append(User(json: entry))
                }
                print("users number=\(self.users.count)")
                    
                //DispatchQueue.main.asynchronously(DispatchQueue.mainexecute: {
                    self.tableRoomOverview.reloadData()
                //})
            } else {
                print("error: could not parse json data")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.addUserData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: table roomoverview stuff
    /*func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        for building in arrBuilding{
            numberOfRooms += building.getNumberOfRooms()
        }
        
        return numberOfRooms
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellRoom")
        
        //cell.textLabel?.text = "test"
        
        //return cell
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellRoom")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellRoom")
        }
        
        let user = self.users[(indexPath as NSIndexPath).row]
        
        cell!.textLabel?.text = user.firstname
        return cell!
    }
    /*
    func testREST(){
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        
        let urlString = NSString(format: "http://localhost:8080/reserveyourroom/api/user/")
        
        print("get wallet balance url string is \(urlString)")
        //let url = NSURL(string: urlString as String)
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: NSString(format: "%@", urlString) as String)
        request.HTTPMethod = "GET"
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = session.dataTaskWithRequest(request) {
            (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? NSHTTPURLResponse, receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            
            switch (httpResponse.statusCode)
            {
            case 200:
                
                let response = NSString (data: receivedData, encoding: NSUTF8StringEncoding)
                print("response is \(response)")
                
                
                do {
                    let getResponse = try NSJSONSerialization.JSONObjectWithData(receivedData, options: .AllowFragments)
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
                break
            case 400:
                
                break
            default:
                print("wallet GET request got response \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
    }*/
}

