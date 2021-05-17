import Foundation
import Moya

enum userAPIUpdateProfile {
    case updateProfile(request: Codable)
}

extension userAPIUpdateProfile: TargetType {
    var baseURL: URL {
        return URL(string: "http://stgapp.mentorz.com:8080/mentorz/api")!

    }
    
    var path: String {
        return "v3/user/\(UserManager.shared.user?.userID)/update"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()

    }
    
    var task: Task {
        switch self {
        case .updateProfile(request: let request):
            return .requestCustomJSONEncodable(request, encoder: JSONEncoder())

        }
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

class UpdateUserProfileRestManager {
    static let userProvider = MoyaProvider<userAPIUpdateProfile>()
    static func updateProfile(request: UpdateUserProfileRequest, handler: ((Result < String,Error>)->())?){
        userProvider.request(.updateProfile(request: request)) { (result) in
            switch result{
            case .success(let response):
                if response.statusCode == 204 {
                    handler?(.success("OK"))
                }
                else {
                    handler?(.failure(NSError()))
                }

            case .failure(let error):
                print(error)
            
            }
        }
}
}
