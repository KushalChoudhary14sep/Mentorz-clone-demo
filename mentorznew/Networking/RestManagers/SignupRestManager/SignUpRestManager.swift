//
//  SignUpRestManager.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 02/03/21.
//

import Foundation
import Moya

class SignUpRestManager {
    static let newprovider = MoyaProvider<userAPISignup>()
    class func SignUp(request: SignUpRequest, handler: ((Result<SignUpResponse,Error>)->())?){
        newprovider.request(.signUp(request: request)) { (result) in
            switch result{
            case .success(let response):
                if response.statusCode == 409 {
                    handler?(.failure(CustomError(errorMsg: "User already exist")))
                }
                do{
                    let product = try JSONDecoder().decode(SignUpResponse.self, from: response.data)
                  
                    if response.statusCode == 201 {
                        handler?(.success(product) )
                        print("Signed In")
                    }
                }
                catch let error{
                    //print("Json Decoding Error", error)
                    handler?(.failure(error))
                }

            case .failure(let error):
                print(error)
            
            }
        }
        
    }
}



class CustomError : Error {
    var value : String
    init(errorMsg : String){
        self.value = errorMsg
    }
}
