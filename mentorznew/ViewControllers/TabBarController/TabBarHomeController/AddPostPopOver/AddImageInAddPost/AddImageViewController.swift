//
//  AddImageViewController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 17/03/21.
//

import UIKit

class AddImageViewController: UIViewController {

    
    @IBOutlet weak var firstVC: UIView!
    
    
    @IBOutlet weak var secondVC: UIView!
    @IBOutlet weak var cancelButton: UIButton!
   
    @IBOutlet weak var photoAlbumSegmentControl: UISegmentedControl!
   
    @IBOutlet weak var noPhotosLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstVC.isHidden = false
        secondVC.isHidden = true
    }

    
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapSegmentControl(_ sender: UISegmentedControl) {

        
        if sender.selectedSegmentIndex == 0 {
            firstVC.isHidden = false
            secondVC.isHidden = true
        }
        else {
            firstVC.isHidden = true
            secondVC.isHidden = false
            
        }
            }
    
    }
    


