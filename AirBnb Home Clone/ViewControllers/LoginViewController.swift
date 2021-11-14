//
//  LoginViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit
import Anchorage

class LoginViewController: UIViewController  {
       
    private lazy var loginView: LoginView = .init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()

    }
    
    override func loadView() {
        view = loginView
        
    }
    private let titleLabel = UILabel()
    
    // MARK: - Private Helpers

    private func configureNavigationBar() {
        let largeFont = UIFont.systemFont(ofSize: 12)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark", withConfiguration: configuration), style: .done, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.title = "로그인 또는 회원 가입"
        
    }
    
    @IBAction func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct WishViewControllerPreview: PreviewProvider {
    static var previews: some View {
            WishViewController().showPreview()
        }
}
#endif
