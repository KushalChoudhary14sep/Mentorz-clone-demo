//
//  SideMenuViewController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 08/03/21.
//

import UIKit

class SideMenuViewController: UIViewController {
   
    @IBOutlet weak var profileImageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
            
            
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapSchedulerButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "SchedulerVC")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve

        present(secondVC, animated: true, completion: nil)
    
    }
    
    @IBAction func didTapOnProfileImage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "EditProfileVC")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve

               present(secondVC, animated: true, completion: nil)
    }
    @IBAction func didTapLogoutButton(_ sender: Any) {
        self.showAlert(title: "Logout", message: "Are you sure you want to Logout") {
        UserManager.shared.logout()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "SplashViewController")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve
        self.present(secondVC, animated: true, completion: nil)
    }
    }
    @IBAction func didTapRingsButton(_ sender: Any) {
    }
    @IBAction func didTapPaymentsButton(_ sender: Any) {
    }
    @IBAction func didTapNotificationsButton(_ sender: Any) {
    }
    @IBAction func didTapFeedBackButton(_ sender: Any) {
    }
   
    func showAlert(title: String, message: String, comletion : (() -> Void)?)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            comletion?()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
  
}
