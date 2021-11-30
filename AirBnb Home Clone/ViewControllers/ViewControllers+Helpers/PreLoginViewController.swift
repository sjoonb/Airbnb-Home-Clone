//
//  PreLoginViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.
//

import UIKit


typealias PreLoginViewController<T: PreViewProtocol> = PreLoginViewControllerClass<T> & PreLoginViewControllerProtocol


protocol PreViewProtocol: ProgrammaticView {
    func configure(with content: LoginContent?)
    var delegate: PreLoginViewDelegate? { get set }
}

protocol PreLoginViewControllerProtocol {
    func updateContent()
}

class PreLoginViewControllerClass<View: PreViewProtocol>: UIViewController, PreLoginViewDelegate {
    
    lazy var contentView: View = .init()
    
    override func loadView() {
        view = contentView
        contentView.delegate = self
        updateContent()
        
    }
    
    func openSheet() {
        let loginViewController = LoginViewController(nibName: nil, bundle: nil)
        //        loginViewController.delegate = self
        
        
        if let sheet = loginViewController.sheetPresentationController {
            sheet.detents = [ .large() ]
            sheet.prefersGrabberVisible = true
        }
        
        present(loginViewController, animated: true, completion: nil)
    }
    
    func updateContent() {
        print("override updateContent function to update content")
    }
}
