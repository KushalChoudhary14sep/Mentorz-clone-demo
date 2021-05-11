//
//  UserManagert.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 08/05/21.
//

import Foundation

class UserManager : NSObject {
    static var shared = UserManager()
    var isUserLoggedin : Bool{
        return self.user != nil
    }
    private override init(){
        
    }
    var user : LoginResponse? {
        get {
            if let user = UserDefaults.standard.data(forKey: "USER"){
                do{
                    let response = try JSONDecoder().decode(LoginResponse.self, from: user)
                    return response
                }catch{
                    return nil
                }
            }else{
                return nil
            }
        }set{
            if let user = newValue{
                do{
                    let data = try JSONEncoder().encode(user)
                    UserDefaults.standard.set(data,forKey: "USER")
                }catch let error {
                    print(error)
                }
            }else{
                UserDefaults.standard.setValue(nil, forKey: "USER")
            }
        }
    }
    
    func logout(){
        self.user = nil
    }
    
    func login(request: LoginRequest, handler: ((Result<LoginResponse,Error>)->())?){
        LoginRestManager.login(request: request){ (result) in
            switch result {
            case .success(let response):
                self.user = response
            case .failure(let error):
                print(error)
            }
            handler?(result)
        }
    }
}
