//
//  Comments.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 11/05/21.
//

import Foundation
// MARK: - PostCommentRespnse
struct PostCommentRespnse: Codable {
    let commentID: Int?
    var comment: String?
    let commentTime, userID: Int?

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case comment
        case commentTime = "comment_time"
        case userID = "user_id"
    }
}

// MARK: - PostCommentRequest
struct PostCommentRequest: Codable {
    let comment: String
}
