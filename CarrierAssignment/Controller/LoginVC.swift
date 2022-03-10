//
//  ViewController.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import UIKit

class LoginVC: BaseViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    var authModel: AuthModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        emailTxtField.layer.masksToBounds = true
        emailTxtField.layer.cornerRadius = 5.0
        emailTxtField.layer.borderWidth = 1
        emailTxtField.layer.borderColor = UIColor.systemBlue.cgColor
        emailTxtField.attributedPlaceholder = NSAttributedString(
            string: " Please enter email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray,NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 14)!]
        )
        
        passwordTxtField.layer.masksToBounds = true
        passwordTxtField.layer.cornerRadius = 5.0
        passwordTxtField.layer.borderWidth = 1
        passwordTxtField.layer.borderColor = UIColor.systemBlue.cgColor
        
        passwordTxtField.attributedPlaceholder = NSAttributedString(
            string: " Please enter password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray,NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 14)!]
        )
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        if emailTxtField.text == "" {
            showAlertMessage(title: "Alert", message: "Please enter email id")
        } else if !isValidEmail(emailTxtField.text ?? "") {
            showAlertMessage(title: "Alert", message: "Please enter valid email id")
        } else if passwordTxtField.text == "" {
            showAlertMessage(title: "Alert", message: "Please enter password")
        } else {
            if CarrierAssignment_SharedInstance.isServerReachable == true {
                showLoader()
                loginAction()
            } else {
                showAlertMessage(title: "Alert", message: "Please check your internet connection")
            }
        }
    }
    
    //MARK: -->Email validator
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: -->LoginAction
    //----To hit login API
    func loginAction() {
        let request = LoginRequest(userEmail: emailTxtField.text ?? "", userPassword: passwordTxtField.text ?? "")
        ApiHandler().callLoginAPI(login: request, complitionHandler: { [weak self] result in
            DispatchQueue.main.async {
                self?.removeLoader()
                switch result {
                case .success(let authModel):
                    self?.emailTxtField.text = ""
                    self?.passwordTxtField.text = ""
                    self?.authModel = authModel
                    CarrierAssignment_SharedInstance.autorizatioToken = authModel.authorization_token
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc: HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self?.navigationController?.pushViewController(vc, animated: true)
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
}

//MARK: -->UITextFieldDelegate
//----Implentation of TextField delegate methods
extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTxtField {
            passwordTxtField.becomeFirstResponder()
        }else if textField == passwordTxtField {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
