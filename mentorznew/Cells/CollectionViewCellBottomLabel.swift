//
//  CollectionViewCellBottomLabel.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 02/03/21.
//

import UIKit

class CollectionViewCellBottomLabel: UICollectionViewCell {
    @IBOutlet weak var imageOfBottomLabel: UIImageView!
    
    @IBOutlet weak var labelOfBottomLabel: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(image: UIImage, label: String) {
        self.imageOfBottomLabel.image = image
        self.labelOfBottomLabel.text = label
    }
}
