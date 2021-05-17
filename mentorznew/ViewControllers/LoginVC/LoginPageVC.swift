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
import CountryPickerView

protocol LoginController: class {
    var passwordTextField: MDCFilledTextField! { get }
    var phoneNumberTextField: MDCFilledTextField! { get }
    var loginButton: LoginSignupButton! { get }
    var facebookButton: UIButton! { get }
    var linkedinButton: UIButton! { get }
    var appleButton: UIButton! { get }
    var countryCodePicker: UIButton! { get }
    var forgotPasswordButton: UIButton! { get }
    var signupButton: UIButton! { get }
    var superView: UIView! { get }
}

class LoginViewController: UIViewController, LoginController {
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var passwordTextField: MDCFilledTextField!
    @IBOutlet weak var phoneNumberTextField: MDCFilledTextField!
    @IBOutlet weak var loginButton: LoginSignupButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var countryCodePicker: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var loginPageVC: LoginPageUIUIVC!
    var loginPageVM: LoginPageVM!
    var cpv :CountryPickerView?
    var selectedCountry : Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginPageVC = LoginPageUIUIVC()
        loginPageVC.view = self
        loginPageVM = LoginPageVM()
        loginPageVM.view = self
    }
}


