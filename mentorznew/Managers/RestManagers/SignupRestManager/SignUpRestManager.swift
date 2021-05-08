//
//  SignUpRestManager.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 02/03/21.
//

import Foundation
import Moya
enum userAPISignup{
    case signUp(request: Codable)
}
extension userAPISignup: TargetType {
    var baseURL: URL {
        return URL(string: "http://stgapp.mentorz.com:8080/mentorz/api")!
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
        let useragent = UIDevice.current.identifierForVendor?.uuidString ?? ""
        return ["user-agent":  useragent,
                "Accept" : "application/json",
                "Content-Type": "application/json"
        ]
    }
    
    
}

class SignUpRestManager {
    static let newprovider = MoyaProvider<userAPISignup>()
    class func SignUp(request: SignUpRequest, handler: ((Result<SignUpResponse,Error>)->())?){
        newprovider.request(.signUp(request: request)) { (result) in
            switch result{
            case .success(let response):
                do{
                    let product = try JSONDecoder().decode(SignUpResponse.self, from: response.data)
                  
                    if response.statusCode == 201 {
                        handler?(.success(product) )
                        print("Signed In")
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
