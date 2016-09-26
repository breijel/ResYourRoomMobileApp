//
//  FirstViewController.swift
//  ReserverYourRoom
//
//  Created by mattafix on 09.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit
import SwiftyJSON

class RomOvViewController: UIViewController, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: properties
    @IBOutlet weak var tableRoomOverview: UITableView!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    
    var picker: UIPickerView!
    var pickerDataSource: [String] = []
    
    @IBOutlet weak var roomTable: UITableView!
    
    var arrBuilding = [Building]()
    var numberOfRooms : Int = 0
    var rooms = [Room]()
    
    override func viewDidLoad() {
        
        self.roomTable.isHidden = false

        self.picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        self.picker.backgroundColor = UIColor.white
        self.picker.showsSelectionIndicator = true
        self.picker.dataSource = self
        self.picker.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RomOvViewController.donePicker(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RomOvViewController.donePicker(_:)))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        cityTextField.inputView = picker
        cityTextField.inputAccessoryView = toolBar
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        RoomService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryRoom = Room(json: entry)
                    self.rooms.append(entryRoom)
                }
                
                DispatchQueue.main.async {
                    self.tableRoomOverview.reloadData()
                }
            } else {
                print("error: could not parse json data")
            }
            print("rooms count = \(self.rooms.count)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRoom") as! TableViewCell
        
        let room = self.rooms[(indexPath as NSIndexPath).row]

        cell.roomname.text = room.name
        
        return cell
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    
    @IBAction func onCityClick(_ sender: UIButton) {
        
        pickerDataSource.removeAll()
        
        AddressService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryAddress = Address(json: entry)
                    self.pickerDataSource.append(entryAddress.city)
                }
                
                DispatchQueue.main.async {
                    self.picker.reloadAllComponents()
                }
            } else {
                print("error: could not parse json data")
            }
            print("city count = \(self.pickerDataSource.count)")
        }

    }
    
    func donePicker(_ sender: AnyObject){
        
    }
}

