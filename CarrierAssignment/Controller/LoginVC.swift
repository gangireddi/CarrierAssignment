//
//  ViewController.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let apiCall = NetworkManager()
        apiCall.callLoginAPi(userName: "masarvghadi1+7@gmail.com", password: "1234Aa|!") {
            
        }
        // Do any additional setup after loading the view.
    }


}

