//
//  UITabBarController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/10/27.
//

import UIKit
import SwiftUI

class AirbnbTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)

        
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.quaternaryLabel.cgColor

        

    }
    
}

