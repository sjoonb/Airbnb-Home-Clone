//
//  ProfileViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit

class PreProfileViewController: PreLoginViewController<ProfilePreLoginView> {
    override func updateContent() {
        let loginContent = LoginSection.profileView.stubData()
        contentView.configure(with: loginContent)
    }
}

