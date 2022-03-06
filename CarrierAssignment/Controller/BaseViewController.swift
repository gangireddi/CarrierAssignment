//
//  BaseViewController.swift
//  CarrierAssignment
//
//  Created by Sandeep on 06/03/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showLoader() {
        let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndictor.color = UIColor.white
        
        let vw: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2.0, height: 120))
        vw.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 10.0
        vw.tag = 123456
        self.view.addSubview(vw)
        
        let lbl = UILabel(frame: CGRect(x: 0, y: vw.frame.size.height/2.0+5, width: vw.frame.size.width, height: 30))
        lbl.numberOfLines = 0
        lbl.text = "Loading\nPlease wait....."
        lbl.font = UIFont(name: "Helvetica Neue", size: 12)!
        lbl.textAlignment = .center
        vw.addSubview(lbl)
        vw.center = self.view.center
        activityIndictor.frame = CGRect(x: 0, y: 0, width: vw.frame.size.width, height: vw.frame.size.height-30)
        vw.addSubview(activityIndictor)
        activityIndictor.startAnimating()
    }
    
    func removeLoader() {
        self.view.viewWithTag(123456)?.removeFromSuperview()
    }
    
    func showAlertMessage(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
