//
//  WishView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import Anchorage
import UIKit

class WishView: ProgrammaticView {
    
    private lazy var loginView: LoginView = .init()
 
    override func configure() {
        backgroundColor = .systemBlue
        loginView.backgroundColor = .systemYellow
    }
    
    override func constrain() {
        addSubview(loginView)
        
        loginView.topAnchor == topAnchor
        loginView.bottomAnchor == bottomAnchor
    }
}
