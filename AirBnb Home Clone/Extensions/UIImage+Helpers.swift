//
//  UIImage+Helpers.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(named name: String?) {
        guard let name = name else { return nil }
        self.init(named: name)
    }
}

extension UIImage {
  static func systemImage(_ systemName: String, tintColor: UIColor) -> UIImage? {
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 13, weight: .regular, scale: .large)
    
    let systemImage = UIImage(systemName: systemName, withConfiguration: largeConfig)
    return systemImage?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
  }
}

extension UIImage {
  var scaledToSafeUploadSize: UIImage? {
    let maxImageSideLength: CGFloat = 480

    let largerSide: CGFloat = max(size.width, size.height)
    let ratioScale: CGFloat = largerSide > maxImageSideLength ? largerSide / maxImageSideLength : 1
    let newImageSize = CGSize(
      width: size.width / ratioScale,
      height: size.height / ratioScale)

    return image(scaledTo: newImageSize)
  }

  func image(scaledTo size: CGSize) -> UIImage? {
    defer {
      UIGraphicsEndImageContext()
    }

    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    draw(in: CGRect(origin: .zero, size: size))

    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
