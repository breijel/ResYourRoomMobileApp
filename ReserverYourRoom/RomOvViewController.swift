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
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var picker: UIPickerView!
    var pickerDataSource: [String] = []
    var startPicker: UIDatePicker!
    var stopPicker: UIDatePicker!
    var result = [RoomDetail]()
    var dataModel = DataModel.sharedInstance
    
    override func viewDidLoad() {
        
        resultLabel.backgroundColor = UIColor.gray
        
        initModel()
        
        initPicker()
        initStartDatePicker()
        initStopDatePicker()
        initBtnStates()
        
        self.tableRoomOverview.isHidden = false
        self.picker.isHidden = true
        self.startPicker.isHidden = true
        self.stopPicker.isHidden = true
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    var roomsCompleted = false
    var addressesCompleted = false
    var infraCompleted = false
    var reservationsCompleted = false
    var wishesCompleted = false
    var buildingsCompleted = false
    
    func initModel(){
        
        RoomService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryRoom = Room(json: entry)
                    self.dataModel.rooms.append(entryRoom)
                }
                self.roomsCompleted = true
                self.fillModel()
                print("rooms count = \(self.dataModel.rooms.count)")
            } else {
                print("error: could not parse json data rooms")
                self.roomsCompleted = true
            }
        }
        
        AddressService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entryAddress = Address(json: entry)
                    self.dataModel.addresses[entryAddress.uuid] = entryAddress
                }
                self.addressesCompleted = true
                self.fillModel()
                print("addresses count = \(self.dataModel.addresses.count)")
            } else {
                print("error: could not parse json data addresses")
                self.addressesCompleted = true
            }
        }
        
        BuildingService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entry = Building(json: entry)
                    self.dataModel.buildings[entry.uuid] = entry
                }
                self.buildingsCompleted = true
                self.fillModel()
                print("buildings count = \(self.dataModel.buildings.count)")
            } else {
                print("error: could not parse json data buildings")
                self.buildingsCompleted = true
            }
        }
        
        InfrastructureService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entry = Infrastructure(json: entry)
                    self.dataModel.infrastructures[entry.uuid] = entry
                }
                self.infraCompleted = true
                self.fillModel()
                print("infrastructures count = \(self.dataModel.infrastructures.count)")
            } else {
                print("error: could not parse json data infra")
                self.infraCompleted = true
            }
        }
        
        ReservationService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entry = Reservation(json: entry)
                    self.dataModel.reservations[entry.uuid] = entry
                }
                self.reservationsCompleted = true
                self.fillModel()
                print("reservations count = \(self.dataModel.reservations.count)")
            } else {
                print("error: could not parse json data reservation")
                self.reservationsCompleted = true
            }
        }
        
        WishService.sharedInstance.getAll{ (json: JSON) in
            if let results = json.array {
                for entry in results {
                    let entry = Wish(json: entry)
                    self.dataModel.wishes[entry.uuid] = entry
                }
                self.wishesCompleted = true
                self.fillModel()
                print("wishes count = \(self.dataModel.wishes.count)")
            } else {
                print("error: could not parse json data wish")
                self.wishesCompleted = true
            }
        }

    }
    
    func fillModel(){
        if(!infraCompleted || !wishesCompleted || !addressesCompleted || !buildingsCompleted || !roomsCompleted || !reservationsCompleted){
            print("skip")
            return
        }
        
        print("Filling model")
        
        for room in self.dataModel.rooms {
            
            let roomDetail = RoomDetail(room: room)
            self.result.append(roomDetail)
        }
        
        print("model count = \(result.count)")
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
        return self.result.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRoom") as! TableViewCell
        
        let roomDetail = self.result[(indexPath as NSIndexPath).row]

        cell.roomname.text = roomDetail.room?.name
        
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
        
        if(self.cityFilter.isSelected){
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
        } else {
            let row: Int = self.picker.selectedRow(inComponent: 0)
            print("City-Filter=\(self.pickerDataSource[row])")
            pickerDataSource.removeAll()
        }

    }
    
    @IBAction func onClickRoomFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.roomFilter)
        
        if(self.roomFilter.isSelected){
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
                print("room count = \(self.pickerDataSource.count)")
            }
        } else {
            let row: Int = self.picker.selectedRow(inComponent: 0)
            print("Room-Filer=\(self.pickerDataSource[row])")
            pickerDataSource.removeAll()
        }
        
    }
    
    @IBAction func onClickStreetFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.streetFilter)
        
        if(self.streetFilter.isSelected){
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
        } else {
            let row: Int = self.picker.selectedRow(inComponent: 0)
            print("Street-Filter=\(self.pickerDataSource[row])")
            pickerDataSource.removeAll()
        }
    
    }

    @IBAction func onClickInfrastructureFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.infrastructureFilter)
        
        if(self.infrastructureFilter.isSelected){
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
        } else {
            let row: Int = self.picker.selectedRow(inComponent: 0)
            print("Infra-Filter=\(self.pickerDataSource[row])")
            pickerDataSource.removeAll()
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
            self.resultLabel.text = "Found: \(self.result.count)"
            
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
        
        if(self.startTime.isSelected){
            
        } else {
            let date: Date = self.startPicker.date
            print("Start-Filter=\(date)")
        }
    }
    
    @IBAction func onClickStopFilter(_ sender: UIButton) {
        
        toggleBtn(self.stopTime)
        toggleViewVisibility(self.stopPicker)
        
        if(self.stopPicker.isSelected){
            
        } else {
            let date: Date = self.stopPicker.date
            print("Start-Filter=\(date)")
        }
    }
    
}



