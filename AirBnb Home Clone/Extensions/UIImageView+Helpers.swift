//
//  UIImageView+Helpers.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.
//

import UIKit

extension UIImageView {
  convenience init(systemImageName: String, tintColor: UIColor? = nil) {
    var systemImage = UIImage(systemName: systemImageName)
    if let tintColor = tintColor {
      systemImage = systemImage?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
    }
    self.init(image: systemImage)
  }
}
