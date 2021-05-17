//
//  ForgotPasswordVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 07/03/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

protocol ForgotPasswordController: class {
    var countryCodeTF: MDCFilledTextField! { get }
    var phoneNumberTF: MDCFilledTextField! { get }
    var continueButton: LoginSignupButton! { get }
    var loginButton: UIButton! { get }
}

class ForgotPasswordVC: UIViewController, ForgotPasswordController {
    @IBOutlet weak var countryCodeTF: MDCFilledTextField!
    @IBOutlet weak var phoneNumberTF: MDCFilledTextField!
    @IBOutlet weak var continueButton: LoginSignupButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var forgotPasswordVC: ForgotPasswordUIVC!
    var forgotPasswordVM: ForgotPasswordVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordVC = ForgotPasswordUIVC()
        forgotPasswordVC.view = self
        forgotPasswordVM = ForgotPasswordVM()
        forgotPasswordVM.view = self
    }
    

}
