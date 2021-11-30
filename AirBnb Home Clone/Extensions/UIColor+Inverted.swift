//
//  UIColor+Inverted.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/10/09.
//

import UIKit

extension UIColor {
    static let invertedBackground = UIColor { traits in
        systemBackground.resolvedColor(with: traits.invertedStyle())
    }
    
    static let invertedLabel = UIColor { traits in
        label.resolvedColor(with: traits.invertedStyle())
    }
}

extension UIColor {
  static var primary: UIColor {
    // swiftlint:disable:next force_unwrapping
      return UIColor.black
  }

  static var incomingMessage: UIColor {
    // swiftlint:disable:next force_unwrapping
    return UIColor(named: "incoming-message")!
  }
}


enum ColorStyle {
    case standard, inverted
}
