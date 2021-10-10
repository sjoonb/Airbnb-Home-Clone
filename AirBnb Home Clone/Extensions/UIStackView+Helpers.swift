//
//  UITextView+Helpers.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/10/09.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in addArrangedSubview(view) }
    }
}
