//
//  File.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 12/05/21.
//

import Foundation
import  UIKit

class FormatDateAndTime {
   static func epocFormatter(time: Int) -> String {
        let timeResult = Double(time/1000)
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
