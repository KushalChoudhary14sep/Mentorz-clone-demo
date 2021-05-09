// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let updateUserProfileRequest = try? newJSONDecoder().decode(UpdateUserProfileRequest.self, from: jsonData)

import Foundation

// MARK: - UpdateUserProfileRequest
struct UpdateUserProfileRequest: Codable {
    let lresID, hresID, basicInfo, name: String
    let videoBioLres, videoBioHres, facebookURL, linkedinURL: String

    enum CodingKeys: String, CodingKey {
        case lresID = "lres_id"
        case hresID = "hres_id"
        case basicInfo = "basic_info"
        case name
        case videoBioLres = "video_bio_lres"
        case videoBioHres = "video_bio_hres"
        case facebookURL = "facebook_url"
        case linkedinURL = "linkedin_url"
    }
}
