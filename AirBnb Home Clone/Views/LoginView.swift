//
//  loginView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Anchorage


class LoginView: ProgrammaticView {
    weak var delegate: AnyObject?
    
    private let headerView = HeaderView()

    private let loginButton = UIButton(type: .roundedRect)
    
    override func configure() {
        backgroundColor = .systemPink
        loginButton.backgroundColor = .systemPink
        loginButton.setTitle("로그인", for: .normal)
    }
    
    override func constrain() {
        addSubview(headerView)
//        loginButton.topAnchor == topAnchor
//        loginButton.horizontalAnchors == horizontalAnchors
        
        headerView.topAnchor == topAnchor
        headerView.horizontalAnchors == horizontalAnchors
        headerView.bottomAnchor == bottomAnchor

    }
}
