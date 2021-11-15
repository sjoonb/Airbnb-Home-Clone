//
//  ProfileViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var preLoginView: ProfilePreLoginView = .init()
    
        override func loadView() {
            view = preLoginView
        }


}
