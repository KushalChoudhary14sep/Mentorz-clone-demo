//
//  GetStoriesRestMangar.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 10/05/21.
//

import Foundation
import Moya

class GetStoriesRestManager {
    static let apiProvider = MoyaProvider<GetUserStories>()
    static let shared = GetStoriesRestManager()
    
    func getStories(page: Int, handler: ((Result<GetStoriesResponse,Error>) -> Void)?) {
        GetStoriesRestManager.apiProvider.request(.getStories(page: page)) { (response) in
            switch response {
            case .success(let response):
                do{
                    let data = try  JSONDecoder().decode(GetStoriesResponse.self, from: response.data)
                    handler?(.success(data))
                }catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getUserProfileImage(userid : Int, handler:  ((Result<UserProfileImageResponse,Error>) -> Void)?){
        GetStoriesRestManager.apiProvider.request(.getProfileImage(userid: userid)) { (response) in
            switch response {
            case .success(let response):
                do{
                    let decoded = try  JSONDecoder().decode(UserProfileImageResponse.self, from: response.data)
                    handler?(.success(decoded))
                }catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getRating(userid : Int, handler: ((Result<RatingResponse,Error>) -> Void)?) {
        GetStoriesRestManager.apiProvider.request(.getRating(userid: userid)) { (response) in
            switch response{
            
            case .success(let response):
                do{
                    let decod = try JSONDecoder().decode(RatingResponse.self, from: response.data)
                    handler?(.success(decod))
                } catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func postLike(postid: Int, handler: ((Result<Bool,Error>) -> Void)?) {
        GetStoriesRestManager.apiProvider.request(.likePost(postid: postid)) { (response) in
            switch response{
            
            case .success(let response):
                if response.statusCode == 204{
                    handler?(.success(true))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func postUnlike(postid: Int, handler: ((Result<Bool,Error>) -> Void)?) {
        GetStoriesRestManager.apiProvider.request(.unlikePost(postid: postid)) { (response) in
            switch response{
            
            case .success(let response):
                if response.statusCode == 204{
                    handler?(.success(true))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getComments(page: Int, postid: Int, handler: ((Result<CommentResponse,Error>) -> Void)?) {
        GetStoriesRestManager.apiProvider.request(.getComment(page: page, postid: postid)) { (response) in
            switch response{
            
            case .success(let response):
                do {
                    let decode = try JSONDecoder().decode(CommentResponse.self, from: response.data)
                    handler?(.success(decode))
                } catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
  class func postComment(request: PostCommentRequest, postid: Int, handler: ((Result<PostCommentRespnse,Error>) -> Void)?) {
        GetStoriesRestManager.apiProvider.request(.postComment(request: request, postid: postid)) { (response) in
            switch response{
            case .success(let response):
                do {
                    let product = try JSONDecoder().decode(PostCommentRespnse.self, from: response.data)
                    handler?(.success(product))
                } catch let error{
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func sharePost(postid: Int, handler: ((Result<Bool,Error>) -> Void)?) {
        GetStoriesRestManager.apiProvider.request(.sharePost(postid: postid)) { (response) in
            switch response{
            
            case .success(let response):
                if response.statusCode == 204 {
                    handler?(.success(true))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
}
