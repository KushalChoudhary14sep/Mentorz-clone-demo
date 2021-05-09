//
//  LoginRestManager.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 03/03/21.
//
import UIKit
import Foundation
import Moya


class LoginRestManager {
    
    static let provider = MoyaProvider<UserAPI>()
    static func login(request: LoginRequest, handler: ((Result<LoginResponse,Error>)->())?){
        provider.request(.login(requset: request)) { (result) in
            switch result{
            case .success(let response):
                do{
                    _ = JSONDecoder()
                    let product = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                    handler?(.success(product))
                    if response.statusCode == 200 {
                        print("loggedin")
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

