//
//  UINavigationBar+Helper.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.
//

import UIKit
import Firebase

protocol UserDisplayable {
  func addProfilePic(_ imageView: UIImageView)
}

extension UINavigationBar: UserDisplayable {
  func addProfilePic(_ imageView: UIImageView) {
    let length = frame.height * 0.46
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = length / 2
    imageView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
      imageView.heightAnchor.constraint(equalToConstant: length),
      imageView.widthAnchor.constraint(equalToConstant: length),
    ])
  }
}
