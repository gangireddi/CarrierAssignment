//
//  DeviceDetailsVC.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import UIKit

class DeviceDetailsVC: UIViewController {
    
    var deviceDataList = [XDeviceModel]()
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDeviceDetails()
    }
    func getDeviceDetails() {
        let apiCall = NetworkManager()
        
        apiCall.callDeviceDetailsAPI(complitionHandler: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let _deviceDataList):
                    self?.deviceDataList = _deviceDataList
                    self?.tblView.reloadData()
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("invalidURL")
                    case .unableToComplete:
                        print("unableToComplete")
                    case .invalidResponse:
                        print("invalidResponse")
                    case .invalidData:
                        print("invalidData")
                    }
                }
            }
        })
    }
}

extension DeviceDetailsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceDetailsCell") as! DeviceDetailsCell
        
        let xDeviceModel = deviceDataList[indexPath.row]
        cell.idLbl.text = "ID: " + (xDeviceModel.id ?? "")
        cell.modelLbl.text = "Model: " + (xDeviceModel.model ?? "")
        if let thVal = xDeviceModel.thval {
            let alarm = "Alarm: " + (thVal.alarm ?? "")
            let humidity = ", Humidity: " + (thVal.hum ?? "")
            let temperature = ", Temperature: " + (thVal.temp ?? "")
            cell.thValLbl.text = alarm + humidity + temperature
        }        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceDataList.count
    }
}
