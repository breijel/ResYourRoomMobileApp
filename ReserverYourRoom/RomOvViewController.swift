//
//  FirstViewController.swift
//  ReserverYourRoom
//
//  Created by mattafix on 09.08.16.
//  Copyright © 2016 mattafix. All rights reserved.
//

import UIKit
import SwiftyJSON

class RomOvViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: properties
    @IBOutlet weak var tableRoomOverview: UITableView!
    @IBOutlet weak var filterView: UIView!

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
    var dataModel = DataModel.sharedInstance
    
    let roomTableViewDelegateAndDS = RoomTableDelegateDataSource()
    
    var roomsCompleted = false
    var addressesCompleted = false
    var infraCompleted = false
    var reservationsCompleted = false
    var wishesCompleted = false
    var buildingsCompleted = false
    
    override func viewDidLoad() {
        
        tableRoomOverview.dataSource = roomTableViewDelegateAndDS
        tableRoomOverview.delegate = roomTableViewDelegateAndDS
        
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
        self.filterView.isHidden = true
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initModel(){
        
        roomsCompleted = false
        addressesCompleted = false
        infraCompleted = false
        reservationsCompleted = false
        wishesCompleted = false
        buildingsCompleted = false
        
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
                    self.dataModel.infrastructures[entry.roomUuid] = entry
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
            return
        }
        
        for room in self.dataModel.rooms {
            
            let building = self.dataModel.buildings[room.buildingUuid]
            let address = self.dataModel.addresses[(building?.addressUuid)!]
            let infra = self.dataModel.infrastructures[room.uuid]
            
            let roomDetail = RoomDetail(room: room, address: address!, building: building!, infrastructure: infra!)
            self.roomTableViewDelegateAndDS.result.append(roomDetail)
        }
        
        DispatchQueue.main.async {
            self.tableRoomOverview.reloadData()
            self.resultLabel.text = "Found: \(self.roomTableViewDelegateAndDS.result.count)"
        }
        
    }
    
    func initPicker(){
        
        self.picker = UIPickerView(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 300))
        self.picker.backgroundColor = UIColor.gray
        self.picker.showsSelectionIndicator = true
        self.picker.dataSource = self
        self.picker.delegate = self
        
        self.filterView.addSubview(picker)
    }
    
    func initStartDatePicker(){
        
        self.startPicker = UIDatePicker(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 300))
        self.startPicker .backgroundColor = UIColor.gray
        self.startPicker .datePickerMode = UIDatePickerMode.dateAndTime
        
        self.filterView.addSubview(self.startPicker)
    }
    
    
    func initStopDatePicker(){
        
        self.stopPicker = UIDatePicker(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 300))
        self.stopPicker.backgroundColor = UIColor.gray
        self.stopPicker.datePickerMode = UIDatePickerMode.dateAndTime
        
        self.filterView.addSubview(self.stopPicker)
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
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
            let results = dataModel.addresses
            for entry in results {
                self.appendInPickerIfAbsent(str: entry.value.city)
            }
                    
            DispatchQueue.main.async {
                self.picker.reloadAllComponents()
            }
            print("city count = \(self.pickerDataSource.count)")

        } else {
            let row: Int = self.picker.selectedRow(inComponent: 0)
            
            //filter
            self.roomTableViewDelegateAndDS.result = self.roomTableViewDelegateAndDS.result.filter { (roomDetail) -> Bool in
                roomDetail.address?.city == self.pickerDataSource[row]
            }
            self.tableRoomOverview.reloadData()
            
            pickerDataSource.removeAll()
        }

    }
    
    @IBAction func onClickRoomFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.roomFilter)
        
        if(self.roomFilter.isSelected){
            let results = dataModel.rooms
            for entry in results {
                self.appendInPickerIfAbsent(str: entry.name)
            }
                    
            DispatchQueue.main.async {
                self.picker.reloadAllComponents()
            }
            print("room count = \(self.pickerDataSource.count)")
            
        } else {
            let row: Int = self.picker.selectedRow(inComponent: 0)
            
            //filter
            self.roomTableViewDelegateAndDS.result = self.roomTableViewDelegateAndDS.result.filter { (roomDetail) -> Bool in
                roomDetail.room?.name == self.pickerDataSource[row]
            }
            self.tableRoomOverview.reloadData()
            
            pickerDataSource.removeAll()
        }
        
    }
    
    @IBAction func onClickStreetFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.streetFilter)
        
        if(self.streetFilter.isSelected){
            let results = dataModel.addresses
            for entry in results {
                self.appendInPickerIfAbsent(str: entry.value.street)
            }
                
            DispatchQueue.main.async {
                self.picker.reloadAllComponents()
            }
            print("street count = \(self.pickerDataSource.count)")
            
        } else {
            let row: Int = self.picker.selectedRow(inComponent: 0)
            
            //filter
            self.roomTableViewDelegateAndDS.result = self.roomTableViewDelegateAndDS.result.filter { (roomDetail) -> Bool in
                roomDetail.address?.street == self.pickerDataSource[row]
            }
            self.tableRoomOverview.reloadData()
            
            pickerDataSource.removeAll()
        }

    
    }

    @IBAction func onClickInfrastructureFilter(_ sender: UIButton) {
        
        toggleViewVisibility(self.picker)
        toggleBtn(self.infrastructureFilter)
        
        if(self.infrastructureFilter.isSelected){
            let results = dataModel.infrastructures
            for entry in results {
                self.appendInPickerIfAbsent(str: entry.value.name)
            }
                
            DispatchQueue.main.async {
                self.picker.reloadAllComponents()
            }
            
            print("Infrastructure count = \(self.pickerDataSource.count)")
            
        } else {
            let row: Int = self.picker.selectedRow(inComponent: 0)
            
            //filter
            self.roomTableViewDelegateAndDS.result = self.roomTableViewDelegateAndDS.result.filter { (roomDetail) -> Bool in
                roomDetail.infrastructure?.name == self.pickerDataSource[row]
            }
            self.tableRoomOverview.reloadData()
            
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
            self.resultLabel.text = "Found: \(self.roomTableViewDelegateAndDS.result.count)"
            
        } else {
            sender.isSelected = true
            sender.alpha = 1
        }
    }
    
    @IBAction func onClickFilter(_ sender: UIButton) {
        
        toggleBtn(self.filterBtn)
        toggleViewVisibility(self.filterView)
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
    
    @IBAction func onClickReload(_ sender: UIButton) {
        
        dataModel.addresses.removeAll()
        dataModel.buildings.removeAll()
        dataModel.infrastructures.removeAll()
        dataModel.reservations.removeAll()
        dataModel.rooms.removeAll()
        dataModel.wishes.removeAll()
        
        self.roomTableViewDelegateAndDS.result.removeAll()
        
        self.initModel()
    }
    
}



