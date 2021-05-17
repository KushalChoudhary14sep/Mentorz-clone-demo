//
//  UIButton.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 14/05/21.
//

import Foundation
import UIKit

extension UIButton {
   
    func setBottomBorder(){
        let lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1))
        lineView.backgroundColor=UIColor.gray
        self.addSubview(lineView)
    }
  
}
