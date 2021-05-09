// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let updateProfileImageRequest = try? newJSONDecoder().decode(UpdateProfileImageRequest.self, from: jsonData)

import Foundation

// MARK: - UpdateProfileImageRequest
struct UpdateProfileImageRequest: Codable {
    let lresID, hresID: String

    enum CodingKeys: String, CodingKey {
        case lresID = "lres_id"
        case hresID = "hres_id"
    }
}
