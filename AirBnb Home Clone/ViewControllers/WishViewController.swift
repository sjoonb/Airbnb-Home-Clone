//
//  WishListViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Firebase

class WishViewController: UIViewController, PreLoginViewDelegate, LoginViewControllerDelegate {
    

//    private lazy var contentView: WishView = .init()
    private lazy var preLoginView: PreLoginView = .init()
    private lazy var wishView: WishView = .init()
    
    private var _user: User?
    var user: User? {
      get { _user ?? Auth.auth().currentUser }
      set { _user = newValue }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
//        view = preLoginView
        preLoginView.delegate = self
        wishView.delegate = self
        
        updatePreLoginViewContent()

    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        if user == nil {
            view = preLoginView
        } else {
            view = wishView
        }
//      configureDataSourceProvider()
    }
    
    private func  updatePreLoginViewContent() {
        let loginContent = LoginSection.wishView.stubData()
        preLoginView.configure(with: loginContent)
    }

    @IBAction func openSheet() {
        // Create the view controller.

        let loginViewController = LoginViewController(nibName: nil, bundle: nil)
        loginViewController.delegate = self
        
//        let navLoginViewController = UINavigationController(rootViewController: loginViewController)
        if let sheet = loginViewController.sheetPresentationController {
            sheet.detents = [ .large() ]
            sheet.prefersGrabberVisible = true
        }
        
        present(loginViewController, animated: true, completion: nil)
    }
    
    
    func updateView() {
        if user == nil {
            view = preLoginView
        } else {
            view = wishView
        }
    }
    
    
}

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct WishViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//            WishViewController().showPreview()
//        }
//}
//#endif
