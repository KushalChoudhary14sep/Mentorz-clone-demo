// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginRequest = try? newJSONDecoder().decode(LoginRequest.self, from: jsonData)

import Foundation

// MARK: - LoginRequest
struct LoginRequest: Codable {
    let emailID: String
    let phoneNumber: PhoneNumber
    let password: String
    let deviceInfo: DeviceInfo

    enum CodingKeys: String, CodingKey {
        case emailID = "email_id"
        case phoneNumber = "phone_number"
        case password
        case deviceInfo = "device_info"
    }
}

// MARK: - DeviceInfo
struct DeviceInfo: Codable {
    let deviceToken, deviceType: String

    enum CodingKeys: String, CodingKey {
        case deviceToken = "device_token"
        case deviceType = "device_type"
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

