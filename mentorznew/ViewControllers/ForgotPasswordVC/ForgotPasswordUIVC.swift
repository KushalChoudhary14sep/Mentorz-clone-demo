//
//  ForgotPasswordUIVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 14/05/21.
//

import Foundation
import UIKit

class ForgotPasswordUIVC: NSObject {
   weak var view: ForgotPasswordController!{
    didSet{
        setUI()
        view.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
     }
    }
    func setUI(){
        TextFieldDesign.textFieldDesign(view.phoneNumberTF,"Phone number")
        TextFieldDesign.textFieldDesign(view.countryCodeTF, "+91")
    }
    @objc func didTapLoginButton(){
    let vc = view as? UIViewController
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let secondVC = storyboard.instantiateViewController(identifier: "LoginViewController")
    secondVC.modalPresentationStyle = .fullScreen
          secondVC.modalTransitionStyle = .crossDissolve
    vc!.present(secondVC, animated: true, completion: nil)
}

}
