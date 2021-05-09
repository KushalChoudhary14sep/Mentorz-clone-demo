//
//  CommentVC.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 09/05/21.
//

import Foundation
import UIKit

class CommentVC : UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapOnBackArrowButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func didTapOnPostButton(_ sender: Any) {
        
    }
    
}
