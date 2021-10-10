//
//  UITextView+Helpers.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/10/09.
//

import UIKit

extension UITextView {

    /// adapted from https://belkadigital.com/articles/uilabel-line-height-in-swift/
    func setLineHeightMultiple(to lineHeightMultiple: CGFloat = 0.0) {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString: NSMutableAttributedString
        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else if let text = text {
            attributedString = NSMutableAttributedString(string: text)
        } else {
            return
        }

        attributedString.addAttribute(.paragraphStyle,
                                      value:paragraphStyle,
                                      range:NSMakeRange(0, attributedString.length))

        attributedText = attributedString
    }
}
