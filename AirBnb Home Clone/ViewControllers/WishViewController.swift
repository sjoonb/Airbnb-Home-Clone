//
//  WishListViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Firebase


class WishViewController: AirbnbViewController<PreLoginView, WishView> {
    override func updatePreLoginViewContent() {
        let loginContent = LoginSection.wishView.stubData()
        preLoginView.configure(with: loginContent)
    }
}
