//
//  TableViewCell.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 05/03/21.
//

import UIKit
import Cosmos
import ExpandableLabel

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
    var data : PostList?
    var commentDelegate: ShowCommentVC?
    var shareDelegate: ShowSharePopOver?
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var postDescriptionLabel: ExpandableLabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
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
        postDescriptionLabel.numberOfLines = 2
        postDescriptionLabel.collapsed = true
        postDescriptionLabel.collapsedAttributedLink = NSAttributedString(string: "Read More")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        
        postDescriptionLabel.numberOfLines = 2
        postDescriptionLabel.isUserInteractionEnabled = true
        postDescriptionLabel.collapsed = true
        postDescriptionLabel.collapsedAttributedLink = NSAttributedString(string: "Read More")
        postDescriptionLabel.ellipsis = NSAttributedString(string: "...")
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
        reportButton.layer.borderWidth = 1
        reportButton.layer.borderColor = UIColor.darkGray.cgColor
        reportButton.layer.cornerRadius = 5
    }
    
    //    func lines(label: UILabel) -> Int {
    //        let textSize = CGSize(width: label.frame.size.width, height: CGFloat(Float.infinity))
    //        let rHeight = lroundf(Float(label.sizeThatFits(textSize).height))
    //        let charSize = lroundf(Float(label.font.lineHeight))
    //        let lineCount = rHeight/charSize
    //        return lineCount
    //    }
    
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
            var username = data.name! + " " + (data.lastName ?? "")
            self.userNameLabel.text = username
            self.postTimeLabel.text = FormatDateAndTime.epocFormatter(time: data.shareTime!)
            self.postDescriptionLabel.setDescriptionLabel(text: data.content.contentDescription ?? "")
            //setPostDescriptionLabel()
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
    
    func setPostDescriptionLabel(){
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.postDescriptionLabel.addGestureRecognizer(tapgesture)
    }
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.data?.content.contentDescription else { return }
        let index = text.index(of:"http")
        if let index = index {
            let link  = text.substring(from: index)
            let range = (text as NSString).range(of: link)
            if gesture.didTapAttributedTextInLabel(label: self.postDescriptionLabel, inRange: range) {
                print("user tapped on text")
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

extension UILabel {
    func setDescriptionLabel(text  :String){
        let index = text.index(of:"http")
        if let index = index {
            let link  = text.substring(from: index)
            var textdata = text.substring(to: index)
            textdata.append(" ")
            textdata.replacingOccurrences(of: "%20", with: " ")
            var finalAttributedString = NSMutableAttributedString(string: textdata)
            var attributedString = NSMutableAttributedString(string: link)
            attributedString.addAttribute(.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
            attributedString.addAttribute(.link, value: link, range: NSRange.init(location: 0, length: attributedString.length))
            attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange.init(location: 0, length: attributedString.length))
            finalAttributedString.append(attributedString)
            self.attributedText = finalAttributedString
        }else{
            self.text = text
        }
    }
    
}



extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        var indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        indexOfCharacter = indexOfCharacter + 4
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
