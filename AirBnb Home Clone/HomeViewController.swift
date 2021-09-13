//
//  ViewController.swift
//  AirBnb Home
//
//  Created by 백성준 on 2021/09/13.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var contentView: HomeView = .init()

    override func loadView() {
        view = contentView
    }

}

