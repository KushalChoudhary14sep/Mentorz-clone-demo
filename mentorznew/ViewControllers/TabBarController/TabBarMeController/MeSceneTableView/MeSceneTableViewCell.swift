//
//  MeSceneTableViewCell.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 18/03/21.
//

import UIKit

class MeSceneTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.systemGray5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
