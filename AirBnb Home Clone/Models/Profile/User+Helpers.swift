//
//  User+Helpers.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/30.
//

import UIKit
import Firebase

extension User: DataSourceProvidable {
  private var infoSection: Section {
    let items = [Item(title: providerID, detailTitle: "Provider ID"),
                 Item(title: uid, detailTitle: "UUID"),
                 Item(title: displayName ?? "––", detailTitle: "Display Name", isEditable: true),
                 Item(
                   title: photoURL?.absoluteString ?? "––",
                   detailTitle: "Photo URL",
                   isEditable: true
                 ),
                 Item(title: email ?? "––", detailTitle: "Email", isEditable: true),
                 Item(title: phoneNumber ?? "––", detailTitle: "Phone Number")]
    return Section(headerDescription: "Info", items: items)
  }

  private var metaDataSection: Section {
    let metadataRows = [
      Item(title: metadata.lastSignInDate?.description, detailTitle: "Last Sign-in Date"),
      Item(title: metadata.creationDate?.description, detailTitle: "Creation Date"),
    ]
    return Section(headerDescription: "Firebase Metadata", items: metadataRows)
  }

  private var otherSection: Section {
    let otherRows = [Item(title: isAnonymous ? "Yes" : "No", detailTitle: "Is User Anonymous?"),
                     Item(title: isEmailVerified ? "Yes" : "No", detailTitle: "Is Email Verified?")]
    return Section(headerDescription: "Other", items: otherRows)
  }

  private var actionSection: Section {
    let actionsRows = [
      Item(title: UserAction.refreshUserInfo.rawValue, textColor: .systemBlue),
      Item(title: UserAction.signOut.rawValue, textColor: .systemBlue),
      Item(title: UserAction.requestVerifyEmail.rawValue, textColor: .systemBlue),
      Item(title: UserAction.tokenRefresh.rawValue, textColor: .systemBlue),
      Item(title: UserAction.delete.rawValue, textColor: .systemRed),
    ]
    return Section(headerDescription: "Actions", items: actionsRows)
  }

  var sections: [Section] {
    [infoSection, metaDataSection, otherSection, actionSection]
  }
}
