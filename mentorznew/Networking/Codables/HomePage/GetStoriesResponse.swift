// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getStoriesResponse = try? newJSONDecoder().decode(GetStoriesResponse.self, from: jsonData)

import Foundation

// MARK: - GetStoriesResponse
struct GetStoriesResponse: Codable {
    let postList: [PostList]

    enum CodingKeys: String, CodingKey {
        case postList = "post_list"
    }
}

// MARK: - PostList
struct PostList: Codable {
    let postID, userID, shareTime: Int?
    var liked: Bool?
    let content: Content
    var viewCount, shareCount,likeCount, commentCount: Int?
    let name, lastName: String?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case userID = "user_id"
        case likeCount = "like_count"
        case shareTime = "share_time"
        case liked, content
        case viewCount = "view_count"
        case shareCount = "share_count"
        case commentCount = "comment_count"
        case name
        case lastName = "last_name"
    }
}

// MARK: - Content
struct Content: Codable {
    let contentID: Int?
    let mediaType: MediaType
    let lresID: String?
    let hresID: String?
    let contentDescription: String?
    let title, url: JSONNull?

    enum CodingKeys: String, CodingKey {
        case contentID = "content_id"
        case mediaType = "media_type"
        case lresID = "lres_id"
        case hresID = "hres_id"
        case contentDescription = "description"
        case title, url
    }
}

enum MediaType: String, Codable {
    case image = "IMAGE"
    case text = "TEXT"
    case video = "VIDEO"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

