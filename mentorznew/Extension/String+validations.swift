//
//  String+validations.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 08/05/21.
//

import Foundation
import UIKit

extension String{
   
    func isValidEmail() -> Bool{
        guard self.count > 0 else {
            return false
        }
        
        let regex = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" + "\\@" + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
            "(" + "\\." + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" + ")+"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = emailTest.evaluate(with: self)
        
        return result
    }
    
    func isValidName() -> Bool {
        guard self.count > 0 else {
            return false
        }
        let RegEx = "^[a-zA-Z]{2,20}$"
        let text = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return text.evaluate(with: self)
    }
    
    func isValidPHnumber() -> Bool {
               let PHONE_REGEX = "^[1-9]{1}[0-9]{9}$"
               let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
               let result = phoneTest.evaluate(with: self)
               return result
           }
    
    
        func isValidPassword() -> Bool {
        guard self.count > 0 else {
            return false
        }
        let RegEx = "^[a-zA-Z0-9@#$%^&*()!_+=?><:]{1,20}$"
        let text = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return text.evaluate(with: self)
    }
}
