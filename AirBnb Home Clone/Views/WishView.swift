//
//  WishView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/16.
//

import UIKit
import Anchorage
import Firebase



class WishView: ProgrammaticView, AirbnbMainViewProtocol {
    
    weak var delegate: LoginViewControllerDelegate?
    
    private let signOutButton = UIButton()
    
    @objc func signOutButtonTabbed() {
        try? Auth.auth().signOut()
        delegate?.updateView()
    }
    
    // MARK: - Configure & Constrain
    
    override func configure() {
        backgroundColor = .white
        signOutButton.setTitle("로그아웃", for: .normal)
        signOutButton.layer.cornerRadius = 10
        signOutButton.backgroundColor = .systemPink
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .semibold)
        signOutButton.addTarget(self, action: #selector(signOutButtonTabbed), for: .touchUpInside)
    }
    
    override func constrain() {
        addSubviews(signOutButton)
        
        signOutButton.centerXAnchor == centerXAnchor
        signOutButton.centerYAnchor == centerYAnchor
        
    }
}
