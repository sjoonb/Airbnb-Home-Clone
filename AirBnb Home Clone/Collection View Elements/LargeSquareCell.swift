//
//  LargeSquareCell.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/14.
//

import Anchorage
import UIKit

typealias LargeSquareCell = ContentCell<LargeSquareView>

class LargeSquareView: ProgrammaticView, ContentConfiguringView {

    private let mainStack = UIStackView()
    private let imageView = UIImageView()
    private let labelStack = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override func configure() {
        mainStack.axis = .vertical
        mainStack.spacing = 10

        imageView.backgroundColor = .secondarySystemFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true

        labelStack.axis = .vertical
        labelStack.spacing = 2

        titleLabel.font = .custom(style: .headline)
        titleLabel.textColor = .label
        subtitleLabel.font = .custom(style: .subheadline)
        subtitleLabel.textColor = .label
    }

    override func constrain() {
        addSubviews(mainStack)
        mainStack.addArrangedSubviews(imageView, labelStack)
        labelStack.addArrangedSubviews(titleLabel, subtitleLabel)

        mainStack.edgeAnchors == edgeAnchors

        imageView.widthAnchor == imageView.heightAnchor
    }

    func configure(with content: Content?) {
        titleLabel.text = content?.title
        subtitleLabel.text = content?.subtitle
        imageView.image = UIImage(named: content?.image)
    }
    
}
