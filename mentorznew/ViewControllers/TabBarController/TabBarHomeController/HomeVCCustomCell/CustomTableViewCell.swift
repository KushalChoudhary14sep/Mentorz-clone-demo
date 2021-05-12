//
//  TableViewCell.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 05/03/21.
//

import UIKit
import Cosmos

protocol ShowCommentVC{
    func didShowCommentVC(cell : TableViewCell)
}
protocol SharePostID {
    var data : PostList? { set get }
    var commentsLabel: UILabel! { get }
}
protocol ShowSharePopOver {
    func didShowSharePopOver(post: PostList)
}

class TableViewCell: UITableViewCell , SharePostID {
    
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
        self.profilePicImage.image = UIImage(named: "default_avt_square")
        self.userNameLabel.text = ""
        self.postTimeLabel.text = ""
        self.ratingView.rating = 0
        self.postDescriptionLabel.text = ""
        self.postImage.image = UIImage(named: "default_avt_square")
        self.likesLabel.text = ""
        self.commentsLabel.text = ""
        self.sharesLabel.text = ""
        self.viewsLabel.text = ""
    }
    
    var isLabelAtMaxHeight = true
    var data : PostList?
    var commentDelegate: ShowCommentVC?
    var shareDelegate: ShowSharePopOver?
    
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
            isLabelAtMaxHeight = true
            labelHeight.constant = 40
        }
        else {
            readMoreButton.setTitle("read less", for: .normal)
            isLabelAtMaxHeight = false
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
    @IBAction func didTapOnCommentButton(_ sender: Any) {
        
        commentDelegate!.didShowCommentVC(cell: self)
        
    }
    @IBAction func didTapOnShareButton(_ sender: Any) {
                
        shareDelegate!.didShowSharePopOver(post: data!)
        
    }
  
    
    func setData(data : PostList?){
        if let data = data {
            self.data = data
                self.userNameLabel.text = data.name! + " " + (data.lastName ?? "")
            self.postTimeLabel.text = FormatDateAndTime.epocFormatter(time: data.shareTime!)
                self.postDescriptionLabel.text = data.content.contentDescription
                ImageDownloder.loadImageFromURL(url: ((data.content.lresID) ?? ""), imageView: self.postImage)
                self.likesLabel.text = "\(data.likeCount!) Likes"
                self.commentsLabel.text = "\(data.commentCount!) Comments"
                self.viewsLabel.text = "\(data.viewCount!) Views"
                self.sharesLabel.text = "\(data.shareCount!) Share"
            
                self.loadImage(userid: data.userID!) { (url) in
                    ImageDownloder.loadImageFromURL(url: url, imageView: self.profilePicImage)
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





