//
//  TravelViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit
import Firebase

class PreTravelViewController: PreLoginViewController<PreLoginView> {
    override func updateContent() {
        let loginContent = LoginSection.travelView.stubData()
        contentView.configure(with: loginContent)
    }
}
