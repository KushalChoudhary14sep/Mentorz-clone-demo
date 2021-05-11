import Foundation
import Moya

enum userAPIUpdateProfileImage {
    case updateProfileImage(request: Codable)
}

extension userAPIUpdateProfileImage: TargetType {
    var baseURL: URL {
        return URL(string: "http://stgapp.mentorz.com:8080/mentorz/api")!
    }
    
    var path: String {
        return "v3/user/" + ("\(UserManager.shared.user?.userID)" ?? "") + "update/profile"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .updateProfileImage(request: let request):
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
class UpdateUserProfileImageRestManager {
    static let userProvider = MoyaProvider<userAPIUpdateProfileImage>()
    static func updateProfile(request: UpdateProfileImageRequest, handler: ((Result < String,Error>)->())?){
        userProvider.request(.updateProfileImage(request: request)) { (result) in
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
