// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? newJSONDecoder().decode(LoginResponse.self, from: jsonData)

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let userID: Int
    let emailID, userName: String
    let userProfile: UserProfile
    let authToken: String
    let isAccountDeactivated, hasInterests, hasValues: Bool
    let phoneNumber: PhoneNumber
    let isNumberVerified: Bool
    let chatToken, name: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case emailID = "email_id"
        case userName = "user_name"
        case userProfile = "user_profile"
        case authToken = "auth_token"
        case isAccountDeactivated = "is_account_deactivated"
        case hasInterests = "has_interests"
        case hasValues = "has_values"
        case phoneNumber = "phone_number"
        case isNumberVerified = "is_number_verified"
        case chatToken = "chat_token"
        case name
    }
}

// MARK: - PhoneNumber
struct PhoneNumber: Codable {
    let cc, isoAlpha2_Cc, number: String

    enum CodingKeys: String, CodingKey {
        case cc
        case isoAlpha2_Cc = "iso_alpha_2_cc"
        case number
    }
}

// MARK: - UserProfile
struct UserProfile: Codable {
    let followers, following, mentors, mentees: Int
    let basicInfo: String
    let birthDate, chargePrice, requests: Int
    let videoBioHres, name: String
    let noofpost: Int

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
