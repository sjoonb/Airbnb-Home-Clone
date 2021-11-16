//
//  ProfileViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit

class ProfileViewController: AirbnbViewController<ProfilePreLoginView, WishView> {
    override func updatePreLoginViewContent() {
        let loginContent = LoginSection.profileView.stubData()
        preLoginView.configure(with: loginContent)
    }
}

