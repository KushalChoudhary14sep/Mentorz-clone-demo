// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let commentResponse = try? newJSONDecoder().decode(CommentResponse.self, from: jsonData)

import Foundation

// MARK: - CommentResponse
struct CommentResponse: Codable {
    let commentList: [CommentList]

    enum CodingKeys: String, CodingKey {
        case commentList = "comment_list"
    }
}

// MARK: - CommentList
struct CommentList: Codable {
    let commentID: Int?
    let comment: String?
    let commentTime, userID: Int?
    let userName, lastName: String?
    let lresID, hresID: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case comment
        case commentTime = "comment_time"
        case userID = "user_id"
        case userName = "user_name"
        case lastName = "last_name"
        case lresID = "lres_id"
        case hresID = "hres_id"
        case name
    }
}

