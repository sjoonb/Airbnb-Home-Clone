//
//  UITabBarController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/10/27.
//

import UIKit

class AirbnbTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)

    }
    
}
