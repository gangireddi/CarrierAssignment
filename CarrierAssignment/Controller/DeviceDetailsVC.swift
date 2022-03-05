//
//  DeviceDetailsVC.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import UIKit

class DeviceDetailsVC: UIViewController {
    
    var authModel: AuthModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func loginAction() {
        let apiCall = NetworkManager()
        
        apiCall.callLoginAPI(userName: "masarvghadi1+7@gmail.com", password: "1234Aa|!", complitionHandler: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authModel):
                    self?.authModel = authModel
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

