//
//  WishListViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Firebase
import FirebaseDatabase

class PreWishViewController: PreLoginViewController<PreLoginView> {
  override func updateContent() {
    let loginContent = LoginSection.wishView.stubData()
    contentView.configure(with: loginContent)
  }
}

class WishViewController: LodgingTableViewController {
  override init() {
    super.init()
    title = "위시리스트"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isToolbarHidden = false
    
    let _ = ref
      .observe(.value) { snapshot in
        var newItems: [LodgingItem] = []
        for child in snapshot.children {
          if
            let snapshot = child as? DataSnapshot,
            let lodgingItem = LodgingItem(snapshot: snapshot), lodgingItem.isFavorite == true {
            newItems.append(lodgingItem)
          }
        }
        self.items = newItems
        self.tableView.reloadData()
      }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
    cell.accessoryView = UIImageView(systemImageName: "heart.fill")
    cell.accessoryView?.tintColor = .systemRed
    
    return cell
  
  }

}

