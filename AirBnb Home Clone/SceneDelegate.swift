//
//  SceneDelegate.swift
//  AirBnb Home
//
//  Created by 백성준 on 2021/09/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else {
      return
    }
    let window = UIWindow(windowScene: windowScene)
    
    AppController.shared.show(in: window)
  }
  
  
}

