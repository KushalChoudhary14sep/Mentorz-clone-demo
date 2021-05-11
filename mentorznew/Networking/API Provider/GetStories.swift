//
//  GetStories.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 10/05/21.
//

import Foundation
import Moya

enum GetUserStories {
    case getStories(page: Int)
    case getProfileImage(userid : Int)
    case getRating(userid: Int)
    case likePost(postid: Int)
    case unlikePost(postid: Int)
    case getComment(page: Int, postid: Int)
}

extension GetUserStories: TargetType{
    var baseURL: URL {
        return URL(string: "https://core.mentorz.com:8443/")!
    }
    
    var path: String {
        switch self {
        case .getStories(page: _):
            return "mentorz/api/v3/user/\(UserManager.shared.user!.userID!)/board"
        case .getProfileImage(userid: let userid):
            return "mentorz/api/v3/user/\(userid)/profile/image"
        case .getRating(userid: let userid):
            return "mentorz/api/v3/user/\(userid)/rating"
        case .likePost(postid: let postid):
            return "mentorz/api/v3/\(UserManager.shared.user!.userID!)/post/\(postid)/like"
        case .unlikePost(postid: let postid):
            return "mentorz/api/v3/\(UserManager.shared.user!.userID!)/post/\(postid)/unlike"
        case .getComment(page: _, postid: let postid):
            return "mentorz/api/v3/\(UserManager.shared.user!.userID!)/post/\(postid)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getStories(page: _):
            return .get
        case .getProfileImage(userid: _):
            return .get
        case .getRating(userid: _):
            return .get
        case .likePost(postid: _):
            return .post
        case .unlikePost(postid: _):
            return .post
        case .getComment(page: _):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
      
        case .getStories(page: let page):
            return .requestParameters(parameters: ["pageNo": page], encoding: URLEncoding.queryString)
        case .getProfileImage:
            return .requestPlain
        case .getRating(userid: _):
            return .requestPlain
        case .likePost(postid: _):
            return .requestPlain
        case .unlikePost(postid: _):
            return .requestPlain
        case .getComment(page: let page, postid: _):
            return .requestParameters(parameters: ["pageNo": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
                "Accept" : "application/json",
                "Content-Type": "application/json",
                "oauth-token": "\(UserManager.shared.user!.authToken!)"
        ]
    }
    
    
}

