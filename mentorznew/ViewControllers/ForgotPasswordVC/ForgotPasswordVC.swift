//
//  ForgotPasswordVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 07/03/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

class ForgotPasswordVC: UIViewController {
    @IBOutlet weak var countryCodeTF: MDCFilledTextField!
    @IBOutlet weak var phoneNumberTF: MDCFilledTextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        TextFieldDesign.textFieldDesign(phoneNumberTF,"Phone number")
        TextFieldDesign.textFieldDesign(countryCodeTF, "+91")
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "LoginViewController")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve

        present(secondVC, animated: true, completion: nil)
    
    }
    
}
