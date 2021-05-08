//
//  EditProfileVCViewController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 18/03/21.
//

import UIKit

class EditProfileVC: UIViewController {
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var backArrowButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var firstNameTextField: UIStackView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var quickDescriptionTextField: UITextField!
    
    @IBOutlet weak var experienceDetailsLabel: UITextField!
    @IBOutlet weak var organizationNameLabel: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var timeZoneButton: UIButton!
    @IBOutlet weak var yearOfExperienceButton: UIButton!
    @IBOutlet weak var linkFBButton: UIButton!
    @IBOutlet weak var linkLIButton: UIButton!
    @IBOutlet weak var myScheduleButton: UIButton!
    @IBOutlet weak var selfieVideoButton1: UIButton!
    @IBOutlet weak var selfieVideoButton2: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rateSlider.maximumTrackTintColor = UIColor.systemGray2
        myScheduleButton.layer.cornerRadius = myScheduleButton.frame.height/2
        selfieVideoButton2.layer.cornerRadius = selfieVideoButton2.frame.height/2
        self.tabBarController?.tabBar.isHidden = false

    }
   
    @IBAction func didTapBAckArrowButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapDoneButton(_ sender: Any) {
    }
    @IBAction func didTapFBLinkButton(_ sender: Any) {
    }
    @IBAction func didTapLILinkButton(_ sender: Any) {
    }
    @IBAction func didTapMyScheduleButton(_ sender: Any) {
  
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let secondVC = storyboard.instantiateViewController(identifier: "SchedulerVC")
        secondVC.modalPresentationStyle = .fullScreen
              secondVC.modalTransitionStyle = .crossDissolve

        present(secondVC, animated: true, completion: nil)
    
    }
    
    @IBAction func didTapSelfieVideo1Button(_ sender: Any) {
    }
    @IBAction func didTapSelfieVideo2Button(_ sender: Any) {
    }
 
    @IBAction func sliderValueChanged(_ sender: Any) {
        rateLabel.frame = CGRect( x: CGFloat(rateSlider.value)/1.5, y: 0, width: rateLabel.frame.size.width, height: rateLabel.frame.size.height )
        rateLabel.text = "$\(Int(rateSlider.value))"
       
        if 0 == Int(rateSlider.value) {
            rateLabel.text = "Free"
        }
    }

}


class CustomSlider: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
            var rect = super.trackRect(forBounds: bounds)
            rect.size.height = 7
            return rect
        }
}
