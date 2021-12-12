//
//  ViewController.swift
//  AirBnb Home
//
//  Created by 백성준 on 2021/09/13.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var contentView: HomeView = .init()
    
    private var statusBarStyle: UIStatusBarStyle = .lightContent
    
    override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle }

    override func loadView() {
        view = contentView
        contentView.delegate = self
        updateList()
    }
    
    private func updateList() {
        var snapShot = NSDiffableDataSourceSnapshot<HomeSection, Content>()
        
        snapShot.appendSections(HomeSection.allCases)
        HomeSection.allCases.forEach( {
            snapShot.appendItems($0.stubData(), toSection: $0)
        })
        
        contentView.apply(snapShot)
    }
    
}


extension HomeViewController: HomeViewDelegate {
    func updateStatusBarStyle(to style: UIStatusBarStyle) {
        if statusBarStyle == .lightContent && traitCollection.userInterfaceStyle == .dark {
            return
        }
        statusBarStyle = style
        UIView.animate(withDuration: 0.4) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
