// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let signUpResponse = try? newJSONDecoder().decode(SignUpResponse.self, from: jsonData)

import Foundation

// MARK: - SignUpResponse
struct SignUpResponse: Codable {
    let userID: Int
    let emailID, userName: String
    let deviceInfo: DeviceInfo
    let userProfile: UserProfile
    let authToken: String
    let phoneNumber: PhoneNumber
    let channels: Channels
    let name: String

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
struct Channels: Codable {
    let channelGroupName, channelName: String

    enum CodingKeys: String, CodingKey {
        case channelGroupName = "channel_group_name"
        case channelName = "channel_name"
    }
}







