//
//  MessageViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit

class MessageViewController: UIViewController {
    
    private lazy var preLoginView: PreLoginView = .init()
    
        override func loadView() {
            view = preLoginView
            update()

        }
    
    private func  update() {
        let loginContent = LoginSection.messageView.stubData()
        preLoginView.configure(with: loginContent)
    }
    
}

