//
//  TravelViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit
import Firebase

class TravelViewController: AirbnbViewController<PreLoginView, WishView> {
    override func updatePreLoginViewContent() {
        let loginContent = LoginSection.travelView.stubData()
        preLoginView.configure(with: loginContent)
    }
}
