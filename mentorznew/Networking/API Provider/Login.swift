//
//  Login.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 09/05/21.
//

import UIKit
import Foundation
import Moya

enum UserAPI {
    case login(requset: Codable)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://core.mentorz.com:8443/mentorz/api/")!
    }
    
    var path: String {
        return "v3/user/login"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(requset: let request) :
            return .requestCustomJSONEncodable(request, encoder: JSONEncoder())
        }
    }
    
    var headers: [String : String]? {
        return [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
    }
    
    
}
