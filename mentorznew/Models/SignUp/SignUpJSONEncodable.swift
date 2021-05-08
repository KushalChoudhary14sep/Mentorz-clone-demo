//
//  SignUpJSONEncodable.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 03/03/21.
//

import Foundation

struct SignUpRequest: Codable {
    let email_id: String?
    let phone_number: PHNumber?
    let password: String?
    let device_info: DeviceInformation?
    let user_profile: UserInfo?
    
}

struct PHNumber: Codable {
    let cc: Int?
    let iso_alpha_2_cc: String?
    let number: Int?
}

struct DeviceInformation: Codable {
    let device_token: String?
    let device_type: String?
}

struct UserInfo: Codable {
    let birth_date: String?
    let name: String?
    let basic_info: String?
    let video_bio_hres: String?
}
