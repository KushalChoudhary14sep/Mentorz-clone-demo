//
//  CommentTableViewCell.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 11/05/21.
//

import UIKit


class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var commentTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetUI()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userProfileImage.image = UIImage(named: "default_avt_square")
        self.userName.text = ""
        self.comment.text = ""
        self.commentTime.text = ""
    }
    
    func SetUI() {
        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.height / 2
    }
    
    func setData(data: CommentList?){
        if let data = data {
            self.userName.text = "\(data.name! + " " + (data.lastName!))"
            self.comment.text = data.comment ?? ""
            self.commentTime.text = FormatDateAndTime.epocFormatter(time: data.commentTime!)
            ImageDownloder.loadImageFromURL(url: (data.lresID ?? "" ), imageView: self.userProfileImage)
        }
    }
    
    
}
