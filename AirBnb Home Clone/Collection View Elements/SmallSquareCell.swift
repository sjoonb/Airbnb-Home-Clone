//
//  SmallSquareCell.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import Anchorage
import UIKit

final class SmallSquareView: ProgrammaticView {
    
    private let imageView = UIImageView()
    private let stack = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override func configure() {
        imageView.backgroundColor = .secondarySystemFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        
        stack.axis = .vertical
        stack.spacing = 8
        
        titleLabel.font = .custom(style: .headline)
        subtitleLabel.font = .custom(style: .subheadline)
    }
    
    override func constrain() {
        addSubviews(imageView, stack)
        stack.addArrangedSubviews(titleLabel, subtitleLabel)
        
        imageView.verticalAnchors == verticalAnchors
        imageView.leadingAnchor == leadingAnchor
        imageView.widthAnchor == imageView.heightAnchor
        
        stack.leadingAnchor == imageView.trailingAnchor + 10
        stack.trailingAnchor == trailingAnchor
        stack.centerYAnchor == centerYAnchor
    }
    
    func configure(with content: Content?) {
        titleLabel.text = content?.title
        subtitleLabel.text = content?.subtitle
        imageView.image = UIImage(named: content?.image)
    }
    
}

final class SmallSquareCell: UICollectionViewCell {
    private lazy var view: SmallSquareView = .init()
    
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
    
    static func registration(showSeparator: @escaping (IndexPath) -> Bool = { _ in false }) -> UICollectionView.CellRegistration<SmallSquareCell, Content> {
        UICollectionView.CellRegistration { cell, indexPath, content in
            cell.configure(with: content)
        }
    }
}
