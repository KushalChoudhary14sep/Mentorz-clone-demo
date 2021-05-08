//
//  SchedulerVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 19/03/21.
//

import UIKit

class SchedulerVC: UIViewController {

    @IBOutlet weak var myAvailableSlotsButton: UIButton!
    
    @IBOutlet weak var checkDayViewButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAvailableSlotsButton.layer.cornerRadius = 4
        checkDayViewButton.layer.cornerRadius = 4

    }
    
    @IBAction func didTapBackArrowButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapAddButton(_ sender: Any) {
    }
    @IBAction func didTapMyAvailableSlotsButton(_ sender: Any) {
    }
    @IBAction func didTapCheckViewButton(_ sender: Any) {
    }
    
    

}
