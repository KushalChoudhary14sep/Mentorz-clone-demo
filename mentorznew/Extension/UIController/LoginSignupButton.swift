//
//  LoginSignupButton.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 02/03/21.
//

import UIKit
import Foundation

class LoginSignupButton: UIButton {
    
    override func awakeFromNib() {
       super.awakeFromNib()
    setTitleColor(.white, for: .normal)
    backgroundColor = .red
    layer.cornerRadius = 5
    titleLabel?.font =  UIFont(name: "systemfont", size: 20)

}
}
