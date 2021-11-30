//
//  LoginViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit
import Anchorage

import Firebase

// For Sign in with Apple
import AuthenticationServices
import CryptoKit

protocol LoginViewControllerDelegate: AnyObject {
    func updateView()
}

class LoginViewController: UIViewController, LoginViewDelegate {
    weak var delegate: LoginViewControllerDelegate?
    private lazy var loginView: LoginView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureNavigationBar()

    }
    
    override func loadView() {
        view = loginView
        loginView.delegate = self
        
    }
    

    // MARK: - LoginViewDelegate
    
    func dismissSheet() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func didSelectItem(_ item: AuthProvider.AuthSection.Item) {
        
        let providerName = item.title!
        
        guard let provider = AuthProvider(rawValue: providerName) else {
            return
        }
        
        switch provider {
        case .email:
            print("email tapped")
            
        case .google:
            print("google tapped")
            
        case .apple:
            performAppleSignInFlow()

        case .facebook:
            print("facebook tapped")
            
        }

    }

    
    // MARK: - Firebase
    
    // For Sign in with Apple

    var currentNonce: String?
    
    private func performAppleSignInFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()

    }
    
//
//    private func configureNavigationBar() {
//        let largeFont = UIFont.systemFont(ofSize: 12)
//        let configuration = UIImage.SymbolConfiguration(font: largeFont)
//
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.backgroundColor = .white
//
//        navigationController?.navigationBar.layer.borderWidth = 1
//        navigationController?.navigationBar.layer.borderColor = UIColor.quaternaryLabel.cgColor
//
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark", withConfiguration: configuration), style: .done, target: self, action: #selector(closeButtonTapped))
//        navigationItem.leftBarButtonItem?.tintColor = .black
//        navigationItem.title = "로그인 또는 회원 가입"
//
//    }
//
//    @IBAction func closeButtonTapped() {
//        dismiss(animated: true, completion: nil)
//    }
    
}


// For Sign in with Apple
extension LoginViewController: ASAuthorizationControllerDelegate,
                              ASAuthorizationControllerPresentationContextProviding {
    // MARK: ASAuthorizationControllerDelegate
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        else {
            print("Unable to retrieve AppleIDCredential")
            return
        }
        
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        
        Auth.auth().signIn(with: credential) { result, error in
            // Error. If error.code == .MissingOrInvalidNonce, make sure
            // you're sending the SHA256-hashed nonce as a hex string with
            // your request to Apple.
            
            // MARK: - Apple SignIn
            
            guard error == nil else { return self.displayError(error) }
            
            // At this point, our user is signed in
            // so we advance to the User View Controller
            self.dismissSheet()
//            self.delegate?.updateView()
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        // Ensure that you have:
        //  - enabled `Sign in with Apple` on the Firebase console
        //  - added the `Sign in with Apple` capability for this project
        print("Sign in with Apple errored: \(error)")
    }
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    // MARK: Aditional `Sign in with Apple` Helpers
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct WishViewControllerPreview: PreviewProvider {
    static var previews: some View {
            PreWishViewController().showPreview()
        }
}
#endif
