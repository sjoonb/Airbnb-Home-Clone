//
//  SmallSquareCell.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import Anchorage
import UIKit

typealias SmallSquareCell = ContentCell<SmallSquareView>


final class SmallSquareView: ProgrammaticView, ContentConfiguringView {
    
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
