//
//  TableViewCell.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 05/03/21.
//

import UIKit
import Cosmos

protocol ShowCommentVC{
    func didShowCommentVC()
    
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    @IBOutlet weak var readMoreButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    var isLabelAtMaxHeight = false
    var data: PostList?
    var commentDelegate: ShowCommentVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUI(){
        self.likeButton.setImage(UIImage(named: "like"), for: .normal)
        contenView.layer.borderWidth = 2
        contenView.layer.borderColor = UIColor.systemGray4.cgColor
        contenView.layer.cornerRadius = 8
        ratingView.rating = 5
        ratingView.settings.starSize = 12
        ratingView.settings.starMargin = 0
        profilePicImage.layer.cornerRadius = profilePicImage.frame.height/2
    }
    
    @IBAction func didTapOnReadMoreButton(_ sender: Any) {
        
        if isLabelAtMaxHeight {
            readMoreButton.setTitle("read more", for: .normal)
            isLabelAtMaxHeight = false
            labelHeight.constant = 70
        }
        else {
            readMoreButton.setTitle("read less", for: .normal)
            isLabelAtMaxHeight = true
            labelHeight.constant = getLabelHeight(width: postDescriptionLabel.bounds.width)        }
    }
    
    func getLabelHeight(width: CGFloat) -> CGFloat {
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        
        return lbl.frame.size.height
    }
    
    
    @IBAction func didTapOnLikeButton(_ sender: Any) {
        DispatchQueue.main.async { [self] in
            if let data = self.data {
                if !(data.liked!) {
                    self.postLike(postid: (data.postID)!) { (result) in
                        if result == true{
                            self.data?.liked = true
                            self.likeButton.setImage(UIImage(named: "selected_like"), for: .normal)
                            self.data?.likeCount! += 1
                            self.likesLabel.text = "\(self.data!.likeCount!) Likes"
                        }
                    }
                }else{
                    self.postUnlike(postid: (data.postID)!) { (result) in
                        if result == true {
                            self.data?.liked = false
                            self.likeButton.setImage(UIImage(named: "like"), for: .normal)
                            self.data?.likeCount! -= 1
                            self.likesLabel.text = "\(self.data!.likeCount!) Likes"
                        }
                    }
                }
            }
            
        }
        
    }
    @IBAction func didTapOnCommentButton(_ sender: Any) {
        
        commentDelegate!.didShowCommentVC()
       
    }
    @IBAction func didTapOnShareButton(_ sender: Any) {
    }
    
    
    func setData(data : PostList?){
        if let data = data {
            self.data = data
            DispatchQueue.main.async {
                self.userNameLabel.text = data.name! + " " + (data.lastName ?? "")
                self.postTimeLabel.text = "\(data.shareTime! / (315360000000 * 5))y ago"
                self.postDescriptionLabel.text = data.content.contentDescription
                self.postImage.imageFromUrl(urlString : ((data.content.lresID) ?? ""), handler : nil)
                self.likesLabel.text = "\(data.likeCount!) Likes"
                self.commentsLabel.text = "\(data.commentCount!) Comments"
                self.viewsLabel.text = "\(data.viewCount!) Views"
                self.sharesLabel.text = "\(data.shareCount!) Share"
                self.loadImage(userid: data.userID!) { (url) in
                    self.profilePicImage.imageFromUrl(urlString: url, handler: nil)
                }
                self.loadRating(userid: data.userID!) { (rating) in
                    self.ratingView.rating = rating
                }
                if self.data?.liked == true {
                    self.likeButton.setImage(UIImage(named: "selected_like"), for: .normal)
                }
                else {
                    self.likeButton.setImage(UIImage(named: "like"), for: .normal)
                }
            }
        }
    }
    
    func loadImage(userid : Int,completion : ((String) -> Void)?) {
        GetStoriesRestManager.shared.getUserProfileImage(userid: userid) { (response) in
            switch response {
            case .success(let response):
                completion?(response.lresID ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
    func loadRating(userid: Int, completion : ((Double) -> Void)?) {
        GetStoriesRestManager.shared.getRating(userid: userid) { (response) in
            switch response{
            case .success(let response):
                completion?(response.rating)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postLike(postid: Int, completion: ((Bool) -> Void)?){
        GetStoriesRestManager.shared.postLike(postid: postid) { (response) in
            switch response{
            case .success(let response):
                completion?(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postUnlike(postid: Int, completion: ((Bool) -> Void)?) {
        GetStoriesRestManager.shared.postUnlike(postid: postid) { (response) in
            switch response{
            case .success(let response):
                completion?(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}




class GetTopMostViewController {
    static func getTopMostViewController() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
}

