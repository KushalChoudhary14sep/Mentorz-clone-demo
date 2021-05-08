//
//  TextFieldDesign.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 08/03/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields


class TextFieldDesign {

    
    static func textFieldDesign(_ textField : MDCFilledTextField,_ title : String){
        textField.label.text = title
      
        textField.setNormalLabelColor(UIColor.gray, for: MDCTextControlState.normal)
        textField.setNormalLabelColor(UIColor.black, for: MDCTextControlState.editing)
        textField.setFloatingLabelColor(UIColor.gray, for: MDCTextControlState.normal)
        textField.setFloatingLabelColor(UIColor.gray, for: MDCTextControlState.editing)
        textField.setTextColor(appColor.alwaysBlackColor, for: MDCTextControlState.normal)
        textField.setTextColor(UIColor.black, for: MDCTextControlState.editing)
        textField.setTextColor(appColor.alwaysBlackColor, for: MDCTextControlState.disabled)
        textField.setFilledBackgroundColor(UIColor.clear, for: MDCTextControlState.editing)
        textField.setFilledBackgroundColor(UIColor.clear, for: MDCTextControlState.normal)
        textField.tintColor = #colorLiteral(red: 0.968627451, green: 0.1803921569, blue: 0.2196078431, alpha: 1)
        textField.textColor = appColor.alwaysBlackColor
        textField.setUnderlineColor(#colorLiteral(red: 0.968627451, green: 0.1803921569, blue: 0.2196078431, alpha: 1) , for: MDCTextControlState.editing)
        textField.setUnderlineColor(UIColor.gray, for: MDCTextControlState.normal)
      
    }
   

}
