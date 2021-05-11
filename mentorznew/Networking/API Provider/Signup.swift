//
//  Signup.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 09/05/21.
//

import Foundation
import Moya

enum userAPISignup{
    case signUp(request: Codable)
}
extension userAPISignup: TargetType {
    var baseURL: URL {
        return URL(string: "https://core.mentorz.com:8443/mentorz/api")!
    }
    
    var path: String {
        return "/v3/user"
    }
    
    var method: Moya.Method {
        return .put
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signUp(request: let request):
            return .requestCustomJSONEncodable(request, encoder: JSONEncoder())
        }
    }
    
    var headers: [String : String]? {
        return [
                "Accept" : "application/json",
                "Content-Type": "application/json"
        ]
    }
    
    
}
