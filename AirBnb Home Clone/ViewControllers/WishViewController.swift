//
//  WishListViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Firebase

class PreWishViewController: PreLoginViewController<PreLoginView> {
    override func updateContent() {
        let loginContent = LoginSection.wishView.stubData()
        contentView.configure(with: loginContent)
    }
    
}
