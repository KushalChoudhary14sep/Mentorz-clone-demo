//
//  CollectionViewCellTopLabel.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 02/03/21.
//

import UIKit

class CollectionViewCellTopLabel: UICollectionViewCell {

    @IBOutlet weak var labelOfTopLabel: UILabel!
    
    @IBOutlet weak var imageOfTopLabel: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    func setData(label: String, image: UIImage) {
       
        self.imageOfTopLabel.image = image
        self.labelOfTopLabel.text = label
    }

}
