//
//  loginView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Anchorage


class ProfilePreLoginView: ProgrammaticView, AirbnbPreViewProtocol {
    
    weak var delegate: PreLoginViewDelegate?
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let textLabel = UILabel()
    private let loginButton = UIButton(type: .roundedRect)
    
    override func configure() {
        
        backgroundColor = .systemBackground
        
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)

        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .systemPink
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        textLabel.textColor = .darkGray
        textLabel.numberOfLines = 0

    }
    
    @objc func loginButtonTapped(sender: UIButton!) {
        delegate?.openSheet()
    }
    
    override func constrain() {
        addSubviews(titleLabel, subtitleLabel, loginButton, textLabel)

        titleLabel.centerYAnchor == centerYAnchor * 0.25
//        titleLabel.topAnchor == topAnchor
        titleLabel.leadingAnchor == leadingAnchor + 30
        
        subtitleLabel.topAnchor == titleLabel.bottomAnchor + 10
        subtitleLabel.leadingAnchor == leadingAnchor + 30
        
        loginButton.topAnchor == subtitleLabel.bottomAnchor + 40
        loginButton.leadingAnchor == leadingAnchor + 30
        loginButton.trailingAnchor == trailingAnchor - 30
        loginButton.heightAnchor == 50
        
        textLabel.topAnchor == loginButton.bottomAnchor + 20
        textLabel.leadingAnchor == leadingAnchor + 30
        textLabel.trailingAnchor == trailingAnchor - 30



    }
    
    func configure(with content: LoginContent?) {
        titleLabel.text = content?.title
        subtitleLabel.text = content?.subtitle
        textLabel.text = content?.text
    }
}

