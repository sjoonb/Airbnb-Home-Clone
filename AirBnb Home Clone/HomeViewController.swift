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
        updateList()
    }
    
    private func updateList() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Content>()
        
        snapShot.appendSections(Section.allCases)
        Section.allCases.forEach( {
            snapShot.appendItems($0.stubData(), toSection: $0)
        })
        
        contentView.apply(snapShot)
    }
    
}

