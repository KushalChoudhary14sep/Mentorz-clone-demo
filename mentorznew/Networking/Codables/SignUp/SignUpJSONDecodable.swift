// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let signupResponse = try? newJSONDecoder().decode(SignupResponse.self, from: jsonData)

import Foundation

// MARK: - SignupResponse
struct SignupResponse: Codable {
    let userID: Int?
    let emailID, userName: String?
    let deviceInfo: SDeviceInfo
    let userProfile: SUserProfile
    let authToken: String?
    let phoneNumber: SPhoneNumber
    let channels: SChannels
    let name: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case emailID = "email_id"
        case userName = "user_name"
        case deviceInfo = "device_info"
        case userProfile = "user_profile"
        case authToken = "auth_token"
        case phoneNumber = "phone_number"
        case channels, name
    }
}

// MARK: - Channels
struct SChannels: Codable {
    let channelGroupName, channelName: String?

    enum CodingKeys: String, CodingKey {
        case channelGroupName = "channel_group_name"
        case channelName = "channel_name"
    }
}

// MARK: - DeviceInfo
struct SDeviceInfo: Codable {
    let userAgent, deviceToken, deviceType: String?

    enum CodingKeys: String, CodingKey {
        case userAgent
        case deviceToken = "device_token"
        case deviceType = "device_type"
    }
}

// MARK: - PhoneNumber
struct SPhoneNumber: Codable {
    let cc, isoAlpha2_Cc, number: String?

    enum CodingKeys: String, CodingKey {
        case cc
        case isoAlpha2_Cc = "iso_alpha_2_cc"
        case number
    }
}

// MARK: - UserProfile
struct SUserProfile: Codable {
    let followers, following, mentors, mentees: Int?
    let basicInfo: String?
    let birthDate, chargePrice, requests: Int?
    let videoBioHres, name: String?
    let noofpost: Int?

    enum CodingKeys: String, CodingKey {
        case followers, following, mentors, mentees
        case basicInfo = "basic_info"
        case birthDate = "birth_date"
        case chargePrice = "charge_price"
        case requests
        case videoBioHres = "video_bio_hres"
        case name, noofpost
    }
}

