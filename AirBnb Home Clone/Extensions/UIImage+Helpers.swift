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
