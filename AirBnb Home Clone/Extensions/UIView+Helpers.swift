//
//  UIView+Helpers.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in addSubview(view) }
    }
    
    func setBackgroundAlpha(_ alpha: CGFloat) {
        backgroundColor = backgroundColor?.withAlphaComponent(alpha)

    }
}
