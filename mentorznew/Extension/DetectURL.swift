//
//  DetectURL.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 12/05/21.
//

import Foundation
import UIKit

class URLDetection {
    
    static func detectURL(input: String) -> String {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        for match in matches {
            guard let range = Range(match.range, in: input) else { continue }
            let url = input[range]
            print(url)
            return String(url)
        }
        return ""
    }
}
