//
//  CustomAlertController.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 17/03/21.
//

import UIKit

class CustomAlertController: UIAlertController {

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()

        let screenBounds = UIScreen.main.bounds

        if (preferredStyle == .actionSheet) {
            self.view.center = CGPoint(x: screenBounds.size.width*0.5, y: screenBounds.size.height - (self.view.frame.size.height*0.5) - 8)
       } else {
        self.view.center = CGPoint(x: screenBounds.size.width*0.5, y: screenBounds.size.height*0.5)
       }
    }

}
