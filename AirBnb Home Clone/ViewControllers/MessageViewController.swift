//
//  MessageViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit

class MessageViewController: AirbnbViewController<PreLoginView, WishView> {
    override func updatePreLoginViewContent() {
        let loginContent = LoginSection.messageView.stubData()
        preLoginView.configure(with: loginContent)
    }
}



