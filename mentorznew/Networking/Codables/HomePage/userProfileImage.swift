// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userProfileImageResponse = try? newJSONDecoder().decode(UserProfileImageResponse.self, from: jsonData)

import Foundation

// MARK: - UserProfileImageResponse
struct UserProfileImageResponse: Codable {
    let lresID, hresID: String?
    let followers, following, mentors, mentees: Int?
    let birthDate, chargePrice, requests, noofpost: Int?

    enum CodingKeys: String, CodingKey {
        case lresID = "lres_id"
        case hresID = "hres_id"
        case followers, following, mentors, mentees
        case birthDate = "birth_date"
        case chargePrice = "charge_price"
        case requests, noofpost
    }
}

