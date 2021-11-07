//
//  WishListViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit

class WishViewController: UIViewController {
    

//    private lazy var contentView: WishView = .init()
    private lazy var loginView: LoginView = .init()
    
        override func loadView() {
            view = loginView
            update()

        }
    
    private func  update() {
        let loginContent = LoginSection.wishView.stubData()
        loginView.configure(with: loginContent)
    }
    
}

