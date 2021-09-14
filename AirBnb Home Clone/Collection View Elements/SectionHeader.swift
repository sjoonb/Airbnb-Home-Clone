//
//  SectionHeader.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/14.
//

import Anchorage
import UIKit

protocol ContentConfiguringHeader: UIView {
    func configure(with content: Content?)
}

final class ContentHeader<View: ContentConfiguringHeader>: UICollectionReusableView {
    private lazy var view: View = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constrain() {
        addSubview(view)
        view.edgeAnchors == edgeAnchors
    }
    
    func configure(with content: Content?) {
        view.configure(with: content)
    }
    
    static func registration(headers: [Content?]) -> UICollectionView.SupplementaryRegistration<ContentHeader<View>> {
        UICollectionView.SupplementaryRegistration(kind: .header) { header, _, indexPath in
            let content = headers[indexPath.section]
            header.configure(with: content)
        }
    }
}

typealias SectionHeader = ContentHeader<SectionHeaderView>

class SectionHeaderView: ProgrammaticView, ContentConfiguringHeader {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override func configure() {
        directionalLayoutMargins = .init(top: 24, leading: 0, bottom: 0, trailing: 0)
        titleLabel.font = .custom(style: .title2)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
        subtitleLabel.font = .custom(style: .title4)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .label
    }

    override func constrain() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4

        addSubview(stackView)
        stackView.edgeAnchors == layoutMarginsGuide.edgeAnchors
    }

    func configure(with content: Content?) {
        titleLabel.text = content?.title
        subtitleLabel.text = content?.subtitle
    }
}


extension UICollectionView {
    enum ElementKind: String {
        case header
    }
}

extension UICollectionView.SupplementaryRegistration {
    init(kind: UICollectionView.ElementKind,
         handler: @escaping UICollectionView.SupplementaryRegistration<Supplementary>.Handler) {
        self.init(elementKind: kind.rawValue, handler: handler)
    }
}
