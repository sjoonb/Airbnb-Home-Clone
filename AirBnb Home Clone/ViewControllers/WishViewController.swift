//
//  WishListViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit

class WishViewController: UIViewController, PreLoginViewDelegate {
    

//    private lazy var contentView: WishView = .init()
    private lazy var preLoginView: PreLoginView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func loadView() {
        view = preLoginView
        preLoginView.delegate = self
        update()

    }
    
    private func  update() {
        let loginContent = LoginSection.wishView.stubData()
        preLoginView.configure(with: loginContent)
    }
    
    @IBAction func openSheet() {
        // Create the view controller.

        let loginViewController = LoginViewController(nibName: nil, bundle: nil)
        
        let navLoginViewController = UINavigationController(rootViewController: loginViewController)
        
        present(navLoginViewController, animated: true, completion: nil)
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
