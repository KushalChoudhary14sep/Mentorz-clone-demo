//
//  TableViewCell.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 05/03/21.
//

import UIKit
import Cosmos

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
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUI(){
        contenView.layer.borderWidth = 2
        contenView.layer.borderColor = UIColor.systemGray4.cgColor
        contenView.layer.cornerRadius = 8
        ratingView.rating = 5
        ratingView.settings.starSize = 12
        ratingView.settings.starMargin = 0
    }
    
}
