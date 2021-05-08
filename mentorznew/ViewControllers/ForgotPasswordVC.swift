//
//  ForgotPasswordVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 07/03/21.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "LoginViewController")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve

        present(secondVC, animated: true, completion: nil)
    
    }
    
}
