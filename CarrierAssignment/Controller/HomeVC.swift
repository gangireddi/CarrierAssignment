//
//  HomeVC.swift
//  CarrierAssignment
//
//  Created by Sandeep on 06/03/22.
//

import UIKit

class HomeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getDeviceDataAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: DeviceDetailsVC = storyboard.instantiateViewController(withIdentifier: "DeviceDetailsVC") as! DeviceDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
