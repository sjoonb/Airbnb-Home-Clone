//
//  UIViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/15.
//

import UIKit

extension UIViewController {
  public func displayError(_ error: Error?, from function: StaticString = #function) {
    guard let error = error else { return }
    print("ⓧ Error in \(function): \(error.localizedDescription)")
    let message = "\(error.localizedDescription)\n\n Ocurred in \(function)"
    let errorAlertController = UIAlertController(
      title: "Error",
      message: message,
      preferredStyle: .alert
    )
    errorAlertController.addAction(UIAlertAction(title: "OK", style: .default))
    present(errorAlertController, animated: true, completion: nil)
  }
}
