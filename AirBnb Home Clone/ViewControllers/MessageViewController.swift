//
//  MessageViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit

class PreMessageViewController: PreLoginViewController<PreLoginView> {
    override func updateContent() {
        let loginContent = LoginSection.messageView.stubData()
        contentView.configure(with: loginContent)
    }
}


