//
//  WishListViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit

class WishViewController: UIViewController {
    

    private lazy var contentView: WishView = .init()
    private lazy var loginView: LoginView = .init()
    private let loginButton = UIButton(type: .roundedRect)

    
    override func loadView() {
        view = loginView

    }
    
}

