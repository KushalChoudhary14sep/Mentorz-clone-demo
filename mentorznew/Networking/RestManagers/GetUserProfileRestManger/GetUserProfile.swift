//
//  GetUserProfile.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 23/03/21.
//

import Foundation
import  Moya

enum userAPIGetUserProfile {
    case getUserProfile
}

extension userAPIGetUserProfile: TargetType {
    var baseURL: URL {
        return URL(string: "http://stgapp.mentorz.com:8080/mentorz/api")!
    }
    
    var path: String {
        return "v3/user/" + ("\(UserManager.shared.user?.userID)" ?? "") + "/profile"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        let useragent = UIDevice.current.identifierForVendor?.uuidString ?? ""
            return ["user-agent":  useragent,
                "Accept" : "application/json",
                "Content-Type": "application/json",
                "oauth-token": "\(UserManager.shared.user!.authToken)"
        ]
    }
    
    
}
class GetUserProfileRestMangaer {
    
    static let provider = MoyaProvider<userAPIGetUserProfile>()
    static func getUserProfile(handler: ((Result<GetUserProfileResponse,Error>)->())?){
        provider.request(.getUserProfile) { (result) in
            switch result{
            case .success(let response):
                do{
                    _ = JSONDecoder()
                    let product = try JSONDecoder().decode(GetUserProfileResponse.self, from: response.data)
                    handler?(.success(product))
                    if response.statusCode == 200 {
                        print("User Profile")
                    }
                }
                catch let error{
                    print("Json Decoding Error", error)
                    handler?(.failure(error))
                }

            case .failure(let error):
                print(error)
            
            }
        }
        
    }
}
