//
//  LoginPageViewController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 02/03/21.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: MDCFilledTextField!
    @IBOutlet weak var phoneNumberTextField: MDCFilledTextField!
    @IBOutlet weak var countyCodePicker: MDCFilledTextField!
    @IBOutlet weak var loginButton: LoginSignupButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextFieldDesign.textFieldDesign(passwordTextField,"Password")
        TextFieldDesign.textFieldDesign(phoneNumberTextField,"Phone number")
        TextFieldDesign.textFieldDesign(countyCodePicker, "+91")
        
        phoneNumberTextField.addTarget(self, action: #selector(didPhoneNumberChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didPasswordChanged), for: .editingChanged)
    }
    @objc func didPhoneNumberChanged() {
        let phNo = self.phoneNumberTextField.text ?? ""
        if !phNo.isValidPHnumber(){
            phoneNumberTextField.leadingAssistiveLabel.text = "Enter a valid Phone Number"
            phoneNumberTextField.leadingAssistiveLabel.textColor = .red
        } else {
            phoneNumberTextField.leadingAssistiveLabel.text = ""
        }
    }
    @objc func didPasswordChanged() {
        let pass = self.passwordTextField.text ?? ""
        if !pass.isValidPassword(){
            passwordTextField.leadingAssistiveLabel.text = "Enter a valid Password"
            passwordTextField.leadingAssistiveLabel.textColor = .red
        } else {
            passwordTextField.leadingAssistiveLabel.text = ""
        }
    }
    
    @IBAction func didTapForgetPasswordButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "ForgotPasswordVC")
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        present(secondVC, animated: true, completion: nil)
    }
    
    
    @IBAction func didTapSignupButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "SplashViewController")
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        present(secondVC, animated: true, completion: nil)
    }
    
    @IBAction func didTapLoginButtonInLoginVC(_ sender: Any) {
        print("LoginButton")
        if validateTextFieldsInLogin() != true{
            return
        }
        let password = self.passwordTextField.text!
        let phoneNumber = self.phoneNumberTextField.text!
        
        UserManager.shared.login(request: LoginRequest(email_id: "", phone_number: PhoneNumber(cc: "91", isoAlpha2_Cc: "in", number: phoneNumber), password: password, device_info: DeviceInfo(device_token: "test_token", device_type: "ANDROID"))) { (result) in
            switch result {
            case .success(let response):
                print(response)
                self.showAlert(title: "Success!", message: "User Successfully Logged In!") {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(identifier: "TabBarRootViewController")
                secondVC.modalPresentationStyle = .fullScreen
                secondVC.modalTransitionStyle = .crossDissolve
                self.present(secondVC, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
                self.showAlert(title: "Error!", message: "User Dosen't Exists!", comletion: nil)
            }
        }
    }
    
    private func validateTextFieldsInLogin() -> Bool{
        let textFields: [UITextField] = [phoneNumberTextField ,passwordTextField]
        for index in 0..<textFields.count {
            guard (textFields[index].text?.count ?? 0) > 0 else {
                let alertMessage = fetchAlertMessage(tag: textFields[index].tag)
                showAlert(title: alertMessage["title"]!, message: alertMessage["message"]!, comletion: nil)
                return false
            }
        }
        if phoneNumberTextField.leadingAssistiveLabel.text?.count ?? 0 > 0 {
            return false
        }
        if passwordTextField.leadingAssistiveLabel.text?.count ?? 0 > 0 {
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
    
    func showAlert(title: String, message: String, comletion : (() -> Void)?)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            comletion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

}
