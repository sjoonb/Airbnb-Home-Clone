//
//  AppController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.

import UIKit
import Firebase

final class AppController {
  static let shared = AppController()
  
  private var window: UIWindow!
  private var rootViewController: UIViewController? {
    didSet {
      window.rootViewController = rootViewController
    }
  }
  
  init() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(handleAppState),
      name: .AuthStateDidChange,
      object: nil)
  }
  
  
  private var tabBarController: UITabBarController = AirbnbTabBarController()
  
  private var homeViewController: UIViewController!
  private var wishViewController: UIViewController!
  
  
  func show(in window: UIWindow?) {
    guard let window = window else {
      fatalError("Cannot layout app with a nil window.")
    }
    
    self.window = window
    window.backgroundColor = .white
    
    handleAppState()
    rootViewController = tabBarController
    
    window.makeKeyAndVisible()
  }
  
  private func configureTabBar() {
    
    let tabBarItems = [UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0),
                       UITabBarItem(title: "위시리스트", image: UIImage(systemName: "heart"), tag: 1),
                       UITabBarItem(title: "여행", image: UIImage(named: "logo"), tag: 2),
                       UITabBarItem(title: "메시지", image: UIImage(systemName: "message"), tag: 3),
                       UITabBarItem(title: "프로필", image: UIImage(systemName: "person.circle"), tag: 4)]
    
    
    tabBarController.viewControllers?.enumerated().forEach { (index, viewController) in
      viewController.tabBarItem = tabBarItems[index]
    }
    
    tabBarController.tabBar.backgroundColor = .white
    tabBarController.tabBar.tintColor = .systemPink
    
  }
  
  
  @objc private func handleAppState() {
    if let user = Auth.auth().currentUser {
      
      AppSettings.displayName = user.displayName ?? ""
      
      let navMessageViewController = NavigationController(MessageViewController(currentUser: user))
      let navProfileViewController = NavigationController(ProfileViewController())
      let navWishViewController = NavigationController(WishViewController())
      let navTravelViewController = NavigationController(SearchViewController())
      
      
      tabBarController.setViewControllers([HomeViewController(), navWishViewController, navTravelViewController, navMessageViewController, navProfileViewController], animated: false)
      
    } else {
      tabBarController.setViewControllers([HomeViewController(), PreWishViewController(), PreTravelViewController(), PreMessageViewController(), PreProfileViewController()], animated: false)
    }
    
    configureTabBar()
    
  }
}
