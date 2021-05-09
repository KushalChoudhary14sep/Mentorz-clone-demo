//
//  SignupDetailsViewController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 02/03/21.
//

import Foundation
import  UIKit

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

class SignupDetailsViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: MDCFilledTextField!
    
    @IBOutlet weak var lastNameTextField: MDCFilledTextField!
    
    @IBOutlet weak var phoneNumberTextField: MDCFilledTextField!
    
    @IBOutlet weak var emailTextField: MDCFilledTextField!
    
    @IBOutlet weak var passwordTextField: MDCFilledTextField!
    
    @IBOutlet weak var signUpButton: LoginSignupButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var countryCodePicker: MDCFilledTextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextFieldDesign.textFieldDesign(passwordTextField,"Password")
        TextFieldDesign.textFieldDesign(phoneNumberTextField,"Phone number")
        TextFieldDesign.textFieldDesign(countryCodePicker, "+91")
        TextFieldDesign.textFieldDesign(firstNameTextField,"First name")
        TextFieldDesign.textFieldDesign(lastNameTextField,"Last name")
        TextFieldDesign.textFieldDesign(emailTextField, "Email ID")
        firstNameTextField.addTarget(self, action: #selector(didFristnameChanged), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(didLastNameChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(didEmailChanged), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(didPhoneNumberChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didPasswordChanged), for: .editingChanged)
        
    }
    @objc func didFristnameChanged(){
        let firstname = self.firstNameTextField.text ?? ""
        if !firstname.isValidName() {
            firstNameTextField.leadingAssistiveLabel.text = "Enter a valid First name"
            firstNameTextField.leadingAssistiveLabel.textColor = .systemRed
        }else{
            self.firstNameTextField.leadingAssistiveLabel.text = ""
        }
    }
    
    @objc func didLastNameChanged() {
        let lastName = self.lastNameTextField.text ?? ""
        if !lastName.isValidName() {
            lastNameTextField.leadingAssistiveLabel.text = "Enter a valid Last name"
            lastNameTextField.leadingAssistiveLabel.textColor = .red
        } else {
            self.lastNameTextField.leadingAssistiveLabel.text = ""
        }
    }
    
    @objc func didEmailChanged() {
        let email = self.emailTextField.text ?? ""
        if !email.isValidEmail(){
            emailTextField.leadingAssistiveLabel.text = "Enter a valid Email"
            emailTextField.leadingAssistiveLabel.textColor = .red
        } else {
            emailTextField.leadingAssistiveLabel.text = ""
        }
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
    

    @IBAction func didTapLoginButtonInSignupDetailsPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "LoginViewController")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve
        self.present(secondVC, animated: true, completion: nil)
    }
    
   
    @IBAction func didTapBackArrowButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "SplashViewController")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve

        self.present(secondVC, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func didTapSignUpButtonForSignUp(_ sender: Any) {
        //text field validations
        if validateTextFields() == false{
            return
        }
        let firstName = self.firstNameTextField.text!
        let lastName = self.lastNameTextField.text!
        let password = self.passwordTextField.text!
        let email = self.emailTextField.text!
        let phoneNumber = Int(self.phoneNumberTextField.text!) ?? 0
        SignUpRestManager.SignUp(request: SignUpRequest(email_id: email, phone_number: PHNumber(cc: 91, iso_alpha_2_cc: "in", number: phoneNumber), password: password, device_info: DeviceInformation(device_token: "testdtoken", device_type: "IOS"), user_profile: UserInfo(birth_date: "", name: firstName+" "+lastName , basic_info: "Java developer", video_bio_hres: ""))) { (result) in
            switch result {
            case .success(_):
                //success alert to user
                self.showAlert(title: "Success!", message: "User Successfully Signedup!") {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                    AppDelegate().shared().window?.rootViewController = vc
                    AppDelegate().shared().window?.makeKeyAndVisible()
                }
                //print(response)
            case .failure(let error):
                if let error = error as? CustomError {
                    //show alert for user already exit error.value
                    self.showAlert(title: "Error!", message: error.value, comletion: nil)
                    //print(error.value)
                }else {
                    //something went wrong
                    self.showAlert(title: "Error!", message: "Something went wrong!", comletion: nil)
                }
            }
        }
    
    }
    
    private func validateTextFields() -> Bool{
    
        let textFields: [UITextField] = [firstNameTextField,lastNameTextField,phoneNumberTextField,passwordTextField,emailTextField]
    
        for index in 0..<textFields.count {
            guard textFields[index].text?.count ?? 0 > 0 else {
                let alertMessage = fetchAlertMessage(tag: textFields[index].tag)
                showAlert(title: alertMessage["title"]!, message: alertMessage["message"]!, comletion: nil)
                return false
            }
        }
        if firstNameTextField.leadingAssistiveLabel.text?.count ?? 0 > 0 {
            return false
        }
        if lastNameTextField.leadingAssistiveLabel.text?.count ?? 0 > 0 {
            return false
        }
        if emailTextField.leadingAssistiveLabel.text?.count ?? 0 > 0 {
            return false
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
            alert["message"] = "Enter a valid input for first name"
        case 1:
            alert["title"] = "Invalid Input"
            alert["message"] = "Enter a valid input for last name"
        case 2:
            alert["title"] = "Invalid Input"
            alert["message"] = "Enter a valid input for phone number"
        case 3:
            alert["title"] = "Invalid Input"
            alert["message"] = "Enter a valid input for email"
        case 4:
            alert["title"] = "Invalid Input"
            alert["message"] = "Enter a valid input for pasword"
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

