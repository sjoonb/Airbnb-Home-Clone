//
//  LogOutViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.
//

import UIKit

class LogoutViewController: UIViewController, LoginViewControllerDelegate {
    
    private lazy var contentView: WishView = .init()
    
    override func loadView() {
        view = contentView
        contentView.delegate = self

    }
    
    func updateView() {
        print(Self.self)
    }
    
    
}
