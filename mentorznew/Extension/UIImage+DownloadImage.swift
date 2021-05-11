//
//  UIImage+DownloadImage.swift
//  mentorznew
//
//  Created by Kushal Choudhary on 10/05/21.
//

import Foundation
import UIKit
extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        
        return image.withRenderingMode(self.renderingMode)
    }
}
