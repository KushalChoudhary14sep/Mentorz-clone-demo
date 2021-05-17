//
//  LoginPageUIVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 14/05/21.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import CountryPickerView

class LoginPageUIUIVC: NSObject, CountryPickerViewDelegate, CountryPickerViewDataSource {
    
    
    weak var view: LoginController!{
        didSet{
            setUI()
            view.phoneNumberTextField.addTarget(self, action: #selector(didPhoneNumberChanged), for: .editingChanged)
            view.passwordTextField.addTarget(self, action: #selector(didPasswordChanged), for: .editingChanged)
            view.countryCodePicker.addTarget(self, action: #selector(didTapOnCountryCodePicker), for: .allEvents)
            self.cpv = CountryPickerView(frame: CGRect(x: 0, y: 0, width: view.superView.frame.size.width, height: view.superView.frame.size.height))
            view.countryCodePicker.setBottomBorder()
            self.cpv?.delegate = self
            self.cpv?.dataSource = self
            self.cpv?.showPhoneCodeInView = true
            view.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButoon), for: .touchUpInside)
            view.signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        }
        
    }
    func setUI() {
        TextFieldDesign.textFieldDesign(view.passwordTextField,"Password")
        TextFieldDesign.textFieldDesign(view.phoneNumberTextField,"Phone number")
    }
    var cpv :CountryPickerView?
    var selectedCountry : Country?
    @objc func didTapOnCountryCodePicker() {
        self.cpv?.showCountriesList(from: self.view as! LoginViewController)
    }
    
    @objc func didPhoneNumberChanged() {
        let phNo = self.view.phoneNumberTextField.text ?? ""
        if !phNo.isValidPHnumber(){
            view.phoneNumberTextField.leadingAssistiveLabel.text = "Enter a valid Phone Number"
            view.phoneNumberTextField.leadingAssistiveLabel.textColor = .red
        } else {
            view.phoneNumberTextField.leadingAssistiveLabel.text = ""
        }
    }
    @objc func didPasswordChanged() {
        let pass = self.view.passwordTextField.text ?? ""
        if !pass.isValidPassword(){
            view.passwordTextField.leadingAssistiveLabel.text = "Enter a valid Password"
            view.passwordTextField.leadingAssistiveLabel.textColor = .red
        } else {
            view.passwordTextField.leadingAssistiveLabel.text = ""
        }
    }
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        selectedCountry = country
        view.countryCodePicker.setTitle(country.phoneCode, for: .normal)
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    @objc func didTapForgotPasswordButoon() {
        let vc = view as? UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "ForgotPasswordVC")
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        vc!.present(secondVC, animated: true, completion: nil)
    }
    @objc func didTapSignupButton() {
        let vc = view as? UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "SplashViewController")
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        vc!.present(secondVC, animated: true, completion: nil)
    }
    
}
