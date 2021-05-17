//
//  UIImage+UrlImage.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 10/05/21.
//
import Foundation
import UIKit
import Nuke

class ImageDownloder {
    // 2
    
    
    static func loadImageFromURL(url : String, imageView : UIImageView){
        var resizedImageProcessors: [ImageProcessing] {
          let imageSize = CGSize(width: 200, height: 200)
          return [ImageProcessors.Resize(size: imageSize, contentMode: .aspectFill)]
        }
        let options = ImageLoadingOptions(
          placeholder: UIImage(named: "default_avt_square"),
          transition: .fadeIn(duration: 0.5)
        )
        let imageURL = URL(string: url)
        
        if let imageURL = imageURL {
            let request = ImageRequest(url: imageURL,processors: resizedImageProcessors)
            Nuke.loadImage(with: request, options: options, into: imageView)
        }
        
        
        
    }
}
