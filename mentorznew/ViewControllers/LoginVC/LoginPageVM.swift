//
//  LoginPageVM.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 14/05/21.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import CountryPickerView

class LoginPageVM: NSObject  {
    
    
    weak var view: LoginController!{
        didSet{
            
            view.loginButton.addTarget(self, action: #selector(didTapOnLoginButton), for: .touchUpInside)
        }
    }
    @objc func didTapOnLoginButton(){
        print("LoginButton")
        let vc = view as? UIViewController
        if validateTextFieldsInLogin() != true{
            return
        }
        let password = self.view.passwordTextField.text!
        let phoneNumber = self.view.phoneNumberTextField.text!
        
        let loginrequest = LoginRequest(emailID: "", phoneNumber: PhoneNumber(cc: "91", isoAlpha2_Cc: "in", number:phoneNumber), password: password, deviceInfo: DeviceInfo(deviceToken: "test_token", deviceType: "ANDROID"))
        UserManager.shared.login(request: loginrequest) { (result) in
            switch result {
            case .success(let response):
                print(response)
                self.showAlert(title: "Success!", message: "User Successfully Logged In!") {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(identifier: "TabBarRootViewController")
                    secondVC.modalPresentationStyle = .fullScreen
                    secondVC.modalTransitionStyle = .crossDissolve
                    vc!.present(secondVC, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
                self.showAlert(title: "Error!", message: "User Dosen't Exists!", comletion: nil)
            }
        }
    }
    func showAlert(title: String, message: String, comletion : (() -> Void)?)  {
        let vc = view as? UIViewController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            comletion?()
        }))
        vc!.present(alert, animated: true, completion: nil)
    }
    
    private func validateTextFieldsInLogin() -> Bool{
        let textFields: [UITextField] = [view.phoneNumberTextField ,view.passwordTextField]
        for index in 0..<textFields.count {
            guard (textFields[index].text?.count ?? 0) > 0 else {
                let alertMessage = fetchAlertMessage(tag: textFields[index].tag)
                showAlert(title: alertMessage["title"]!, message: alertMessage["message"]!, comletion: nil)
                return false
            }
        }
        if view.phoneNumberTextField.leadingAssistiveLabel.text?.count ?? 0 > 0 {
            return false
        }
        if view.passwordTextField.leadingAssistiveLabel.text?.count ?? 0 > 0 {
            return false
        }
        return true
    }
    
    func fetchAlertMessage(tag: Int) -> [String: String]{
        var alert = [String: String]()
        switch tag {
        case 0:
            alert["title"] = "Invalid Input"
            alert["message"] = "Enter a valid input for phone number"
        case 1:
            alert["title"] = "Invalid Input"
            alert["message"] = "Enter a valid input for paswword"
        default:
            alert["title"] = "Invalid Input"
            alert["message"] = "Enter a valid input"
        }
        return alert
    }
}
