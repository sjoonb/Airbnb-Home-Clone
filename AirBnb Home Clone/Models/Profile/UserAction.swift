//
//  UserAction.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.
//

import Foundation

enum UserAction: String {
  case signOut = "Sign Out"
  case requestVerifyEmail = "Request Verify Email"
  case tokenRefresh = "Token Refresh"
  case delete = "Delete"
  case updateEmail = "Email"
  case updatePhotoURL = "Photo URL"
  case updateDisplayName = "Display Name"
  case refreshUserInfo = "Refresh User Info"
}
