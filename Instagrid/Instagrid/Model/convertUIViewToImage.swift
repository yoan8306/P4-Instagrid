//
//  convertUIViewToImage.swift
//  Instagrid
//
//  Created by Yoan on 09/09/2021.
//

import Foundation
import UIKit

extension UIView {
    /// make scale all subView
    /// - Parameter scale: we can configure scale
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }

    /// transform UiView to UiImage
    /// - Parameter scale: scale = nil because don't touch scale in this case
    /// - Returns: An image for sharing
    func getImage(scale: CGFloat? = nil) -> UIImage {
        let newScale = scale ?? UIScreen.main.scale
        self.scale(by: newScale)

        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale

        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)

        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }
        return image
    }
}
