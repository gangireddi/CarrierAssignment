//
//  DeviceDetailsVC.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import UIKit

class DeviceDetailsVC: BaseViewController {
    
    var deviceDataList = [XDeviceModel]()
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CarrierAssignment_SharedInstance.isServerReachable == true {
            showLoader()
            getDeviceDetails()
        } else {
            showAlertMessage(title: "Alert", message: "Please check your internet connection")
        }
    }
    
    //MARK: -->LoginAction
    //----To hit login API
    func getDeviceDetails() {        
        ApiHandler().callDeviceDetailsAPI(complitionHandler: { [weak self] result in
            DispatchQueue.main.async {
                self?.removeLoader()
                switch result {
                case .success(let _deviceDataList):
                    self?.deviceDataList = _deviceDataList
                    self?.tblView.reloadData()
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self?.showAlertMessage(title: "Alert", message: "invalidURL")
                    case .unableToComplete:
                        self?.showAlertMessage(title: "Alert", message: "unableToComplete")
                    case .invalidResponse:
                        self?.showAlertMessage(title: "Alert", message: "invalidResponse")
                    case .invalidData:
                        self?.showAlertMessage(title: "Alert", message: "invalidData")
                    }
                }
            }
        })
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: -->UITableViewDelegate,UITableViewDataSource
//----Implentation of TableView delegate and datasource methods

extension DeviceDetailsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceDetailsCell") as! DeviceDetailsCell
        
        let xDeviceModel = deviceDataList[indexPath.row]
        cell.idLbl.text = "ID: " + (xDeviceModel.id ?? "")
        cell.modelLbl.text = "Model: " + (xDeviceModel.model ?? "")
        cell.cellBgVw.backgroundColor = indexPath.row%2 == 0 ? UIColor.systemBlue.withAlphaComponent(1.0) : UIColor.systemBlue.withAlphaComponent(0.7)
        if let thVal = xDeviceModel.thval {
            let alarm = "Alarm: " + (thVal.alarm ?? "")
            let humidity = ", Humidity: " + (thVal.hum ?? "")
            let temperature = ", Temperature: " + (thVal.temp ?? "")
            cell.thValLbl.text = alarm + humidity + temperature
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceDataList.count
    }
}
