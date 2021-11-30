//
//  AppSettings.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.
//

import Foundation

enum AppSettings {
  static private let displayNameKey = "DisplayName"
  static var displayName: String {
    get {
      // swiftlint:disable:next force_unwrapping
      return UserDefaults.standard.string(forKey: displayNameKey)!
    }
    set {
      UserDefaults.standard.set(newValue, forKey: displayNameKey)
    }
  }
}
