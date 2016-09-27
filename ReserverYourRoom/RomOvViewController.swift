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
    
    @IBOutlet weak var streetFilter: UIButton!
    @IBOutlet weak var roomFilter: UIButton!
    @IBOutlet weak var cityFilter: UIButton!
    @IBOutlet weak var infrastructureFilter: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var stopTime: UIButton!
    @IBOutlet weak var startTime: UIButton!
    
    var picker: UIPickerView!
    var pickerDataSource: [String] = []
    var startPicker: UIDatePicker!
    var stopPicker: UIDatePicker!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var roomTable: UITableView!
    
    var arrBuilding = [Building]()
    var numberOfRooms : Int = 0
    var rooms = [Room]()
    
    override func viewDidLoad() {
        
        resultLabel.backgroundColor = UIColor.gray
        
        initPicker()
        initStartDatePicker()
        initStopDatePicker()
        initBtnStates()
        
        self.roomTable.isHidden = false
        self.picker.isHidden = true
        self.startPicker.isHidden = true
        self.stopPicker.isHidden = true
        
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
                    self.resultLabel.text = "Found: \(self.rooms.count)"
                }
            } else {
                print("error: could not parse json data")
            }
            print("rooms count = \(self.rooms.count)")
        }
        
    }
    
    func initPicker(){
        
        self.picker = UIPickerView(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 300))
        self.picker.backgroundColor = UIColor.gray
        self.picker.showsSelectionIndicator = true
        self.picker.dataSource = self
        self.picker.delegate = self
        
        self.view.addSubview(picker)
    }
    
    func initStartDatePicker(){
        
        self.startPicker = UIDatePicker(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 300))
        self.startPicker .backgroundColor = UIColor.gray
        self.startPicker .datePickerMode = UIDatePickerMode.dateAndTime
        
        self.view.addSubview(self.startPicker )
    }
    
    
    func initStopDatePicker(){
        
        self.stopPicker = UIDatePicker(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 300))
        self.stopPicker.backgroundColor = UIColor.gray
        self.stopPicker.datePickerMode = UIDatePickerMode.dateAndTime
        
        self.view.addSubview(self.stopPicker )
    }
    
    func initBtnStates(){
        
        self.cityFilter.isSelected = false
        self.cityFilter.alpha = 0.5
        self.roomFilter.isSelected = false
        self.roomFilter.alpha = 0.5
        self.infrastructureFilter.isSelected = false
        self.infrastructureFilter.alpha = 0.5
        self.streetFilter.isSelected = false
        self.streetFilter.alpha = 0.5
        self.filterBtn.isSelected = false
        self.filterBtn.alpha = 0.5
        self.stopTime.isSelected = false
        self.stopTime.alpha = 0.5
        self.startTime.isSelected = false
        self.startTime.alpha = 0.5
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
    
    func donePicker(_ sender: AnyObject){
        
    }
    
    private func appendInPickerIfAbsent(str: String){
        
        for e in self.pickerDataSource{
            if(e == str){
                return
            }
        }
        
        self.pickerDataSource.append(str)
    }
    
    @IBAction func onClickCityFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.cityFilter)
        
        pickerDataSource.removeAll()
        AddressService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryAddress = Address(json: entry)
                    self.appendInPickerIfAbsent(str: entryAddress.city)
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
    
    @IBAction func onClickRoomFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.roomFilter)
        
        pickerDataSource.removeAll()
        RoomService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryRoom = Room(json: entry)
                    self.appendInPickerIfAbsent(str: entryRoom.name)
                }
                
                DispatchQueue.main.async {
                    self.picker.reloadAllComponents()
                }
            } else {
                print("error: could not parse json data")
            }
            print("city room = \(self.pickerDataSource.count)")
        }
    }
    
    @IBAction func onClickStreetFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.streetFilter)
        
        pickerDataSource.removeAll()
        AddressService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryAddress = Address(json: entry)
                    self.appendInPickerIfAbsent(str: entryAddress.street)
                }
                
                DispatchQueue.main.async {
                    self.picker.reloadAllComponents()
                }
            } else {
                print("error: could not parse json data")
            }
            print("street count = \(self.pickerDataSource.count)")
        }
    }
    
    @IBAction func onClickInfrastructureFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.infrastructureFilter)
        
        pickerDataSource.removeAll()
        InfrastructureService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryInfra = Infrastructure(json: entry)
                    self.appendInPickerIfAbsent(str: entryInfra.name)
                }
                
                DispatchQueue.main.async {
                    self.picker.reloadAllComponents()
                }
            } else {
                print("error: could not parse json data")
            }
            print("Infrastructure count = \(self.pickerDataSource.count)")
        }
    }
    
    func toggleViewVisibility(_ sender: UIView) {
        
        if(sender.isHidden){
            sender.isHidden = false
        } else {
            sender.isHidden = true
        }
    }
    
    func toggleBtn(_ sender: UIButton){
        if(sender.isSelected){
            sender.isSelected = false
            sender.alpha = 0.5
            self.resultLabel.text = "Found: \(self.rooms.count)"
            
        } else {
            sender.isSelected = true
            sender.alpha = 1
        }
    }
    
    @IBAction func onClickFilter(_ sender: UIButton) {
        
        toggleBtn(self.filterBtn)
        toggleViewVisibility(self.tableRoomOverview)
    }
    
    @IBAction func onClickStartFilter(_ sender: UIButton) {
        
        toggleBtn(self.startTime)
        toggleViewVisibility(self.startPicker)
    }
    
    @IBAction func onClickStopFilter(_ sender: UIButton) {
        
        toggleBtn(self.stopTime)
        toggleViewVisibility(self.stopPicker)
    }
    
}



