//
//  ContentCell.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/14.
//

import Anchorage
import UIKit

protocol ContentConfiguringView: UIView {
    func configure(with content: Content?)
}

final class ContentCell<View: ContentConfiguringView>: UICollectionViewCell {
    private lazy var view: View = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constrain() {
        contentView.addSubview(view)
        view.edgeAnchors == contentView.edgeAnchors
    }
    
    func configure(with content: Content?) {
        view.configure(with: content)
    }
    
    static func registration(showSeparator: @escaping (IndexPath) -> Bool = { _ in false }) -> UICollectionView.CellRegistration<ContentCell<View>, Content> {
        UICollectionView.CellRegistration { cell, indexPath, content in
            cell.configure(with: content)
        }
    }
}
