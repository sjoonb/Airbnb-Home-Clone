//
//  MessageViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit

class MessageViewController: UIViewController {
    
    private lazy var loginView: LoginView = .init()
    
        override func loadView() {
            view = loginView
            update()

        }
    
    private func  update() {
        let loginContent = LoginSection.messageView.stubData()
        loginView.configure(with: loginContent)
    }
    
}

