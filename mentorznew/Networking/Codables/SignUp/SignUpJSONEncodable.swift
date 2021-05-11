// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let signUpRequest = try? newJSONDecoder().decode(SignUpRequest.self, from: jsonData)

import Foundation

// MARK: - SignUpRequest
struct SignUpRequest: Codable {
    let emailID: String
    let phoneNumber: SSPhoneNumber
    let password: String
    let deviceInfo: SSDeviceInfo
    let userProfile: SSUserProfile

    enum CodingKeys: String, CodingKey {
        case emailID = "email_id"
        case phoneNumber = "phone_number"
        case password
        case deviceInfo = "device_info"
        case userProfile = "user_profile"
    }
}

// MARK: - DeviceInfo
struct SSDeviceInfo: Codable {
    let deviceToken, deviceType: String

    enum CodingKeys: String, CodingKey {
        case deviceToken = "device_token"
        case deviceType = "device_type"
    }
}

// MARK: - PhoneNumber
struct SSPhoneNumber: Codable {
    let cc, isoAlpha2_Cc, number: String

    enum CodingKeys: String, CodingKey {
        case cc
        case isoAlpha2_Cc = "iso_alpha_2_cc"
        case number
    }
}

// MARK: - UserProfile
struct SSUserProfile: Codable {
    let birthDate, name, basicInfo, videoBioHres: String

    enum CodingKeys: String, CodingKey {
        case birthDate = "birth_date"
        case name
        case basicInfo = "basic_info"
        case videoBioHres = "video_bio_hres"
    }
}

