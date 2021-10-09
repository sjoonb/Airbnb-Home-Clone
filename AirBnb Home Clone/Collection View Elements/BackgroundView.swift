//
//  BackgroundView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/10/09.
//

import UIKit

class BackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = provideBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = provideBackgroundColor()
    }
    
    func provideBackgroundColor() -> UIColor? { nil }
}

final class InvertedBackGroundView: BackgroundView {
    override func provideBackgroundColor() -> UIColor? {
        .invertedBackground
    }
}

enum BackgroundStyle: String, CaseIterable {
    case inverted
    
    var elementKind: String { "background.\(rawValue)" }
    
    var viewClass: AnyClass {
        switch self {
        case .inverted: return InvertedBackGroundView.self
        }
    }
}

extension UICollectionViewLayout {
    func registerBackgrounds() {
        BackgroundStyle.allCases.forEach {
            register($0.viewClass, forDecorationViewOfKind: $0.elementKind)
        }
    }
}

extension NSCollectionLayoutSection {
    func addBackground(style: BackgroundStyle) {
        decorationItems.append(.background(elementKind: style.elementKind))
    }
}

