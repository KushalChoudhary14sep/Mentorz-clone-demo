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
        
    }
    
    func SetUI() {
        self.userProfileImage.layer.cornerRadius = self.frame.size.height / 2
    }
    
    
}
