//
//  LoginJSON.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 02/03/21.
//

import Foundation
struct LoginRequest: Codable {
    let email_id: String?
    let phone_number: PhoneNumber?
    let password: String?
    let device_info: DeviceInfo?
}
struct DeviceInfo: Codable{
    let device_token: String?
    let device_type: String?
}

