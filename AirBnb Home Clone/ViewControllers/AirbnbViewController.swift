//
//  AirbnbViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/16.
//

import UIKit
import Firebase

protocol AirbnbPreViewProtocol: ProgrammaticView {
    func configure(with content: LoginContent?)
    var delegate: PreLoginViewDelegate? { get set }
}

protocol AirbnbMainViewProtocol: ProgrammaticView {
    var delegate: LoginViewControllerDelegate? { get set }
}

class AirbnbViewController<PreView: AirbnbPreViewProtocol, MainView: AirbnbMainViewProtocol>: UIViewController, LoginViewControllerDelegate, PreLoginViewDelegate {
    internal var preLoginView: PreView = .init()
    private var mainView: MainView = .init()
    private var pastUser: User? = Auth.auth().currentUser

    private lazy var updatePreLoginViewContentOnce: Void = {
        updatePreLoginViewContent()
    }()

    override func loadView() {
        preLoginView.delegate = self
        mainView.delegate = self

        let currentUser = user
        convertViewDependingOnUser(currentUser)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        
        let currentUser = user
        if currentUser == pastUser { return }

        convertViewDependingOnUser(currentUser)
        
        pastUser = currentUser

    }
    
    // MARK: - PreLoginViewDelegate

    @IBAction func openSheet() {

        let loginViewController = LoginViewController(nibName: nil, bundle: nil)
        loginViewController.delegate = self
        

        if let sheet = loginViewController.sheetPresentationController {
            sheet.detents = [ .large() ]
            sheet.prefersGrabberVisible = true
        }
        
        present(loginViewController, animated: true, completion: nil)
    }
    
    // MARK: - LoginViewControllerDelegate
    
    func updateView() {
        self.viewWillAppear(true)
    }
    
    // MARK: - Private Helpers
    
    private func convertViewDependingOnUser(_ currentUser: User?) {
        if currentUser == nil {
            view = preLoginView
            _ = updatePreLoginViewContentOnce
        } else {
            view = mainView
        }
    }
    
    // MARK: - For Child Class
    
    func updatePreLoginViewContent() {
        
    }
    
}
