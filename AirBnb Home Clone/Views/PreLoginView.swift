//
//  loginView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Anchorage

protocol PreLoginViewDelegate: AnyObject {
    func openSheet()
}


class PreLoginView: ProgrammaticView {
    
    weak var delegate: PreLoginViewDelegate?
    
    private let titleLabel = UILabel()
    private let separator = UIView()
    private let subtitleLabel = UILabel()
    private let textLabel = UILabel()
    private let loginButton = UIButton(type: .roundedRect)
    
    override func configure() {
        
        backgroundColor = .systemBackground
        
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)

        separator.backgroundColor = .quaternaryLabel
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)

        textLabel.textColor = UIColor.gray
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textLabel.numberOfLines = 0
        
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .systemPink
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        loginButton.contentEdgeInsets = .init(top: 14, left: 28, bottom: 14, right: 28)

        loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped(sender: UIButton!) {
        delegate?.openSheet()
    }
    
    override func constrain() {
        addSubviews(titleLabel, separator, subtitleLabel, textLabel, subtitleLabel, textLabel, loginButton)

        titleLabel.centerYAnchor == centerYAnchor * 0.25
//        titleLabel.topAnchor == topAnchor
        titleLabel.leadingAnchor == leadingAnchor + 30
        
        separator.topAnchor == titleLabel.bottomAnchor + 60
        separator.centerXAnchor == centerXAnchor
        separator.heightAnchor == 1
        separator.widthAnchor == widthAnchor - 60
        
        subtitleLabel.topAnchor == separator.bottomAnchor + 40
        subtitleLabel.leadingAnchor == leadingAnchor + 30
        
        textLabel.topAnchor == subtitleLabel.bottomAnchor + 10
        textLabel.leadingAnchor == leadingAnchor + 30
        textLabel.trailingAnchor == trailingAnchor - 30

        loginButton.topAnchor == textLabel.bottomAnchor + 20
        loginButton.leadingAnchor == leadingAnchor + 30

    }
    
    func configure(with content: LoginContent?) {
        titleLabel.text = content?.title
        subtitleLabel.text = content?.subtitle
        textLabel.text = content?.text
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct PreLoginViewPreview: PreviewProvider{
    static var previews: some View {
        Group {
            UIViewPreview {
                let view = PreLoginView()
                view.configure(with: LoginSection.wishView.stubData())
                return view
            }.previewDevice("iPhone 11").previewLayout(.sizeThatFits)
            UIViewPreview {
                let view = PreLoginView()
                view.configure(with: LoginSection.wishView.stubData())
                return view
            }.previewDevice("iPhone SE (2nd generation)").previewLayout(.sizeThatFits)
        }
    }
}
#endif
