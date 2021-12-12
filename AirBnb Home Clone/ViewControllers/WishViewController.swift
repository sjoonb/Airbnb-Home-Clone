//
//  WishListViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/05.
//

import UIKit
import Firebase

class PreWishViewController: PreLoginViewController<PreLoginView> {
  override func updateContent() {
    let loginContent = LoginSection.wishView.stubData()
    contentView.configure(with: loginContent)
  }
}

class WishViewController: UITableViewController {
  let ref = Database.database().reference(withPath: "lodging-items")
  private let itemCellIdentifier = "ItemCell"

  var items: [LodgingItem] = []
  
  init() {
    super.init(style: .grouped)
    
    title = "위시리스트"
    tableView.backgroundColor = .white
     
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isToolbarHidden = false
    
    let _ = ref
      .queryOrdered(byChild: "completed")
      .observe(.value) { snapshot in
        var newItems: [LodgingItem] = []
        for child in snapshot.children {
          if
            let snapshot = child as? DataSnapshot,
            let lodgingItem = LodgingItem(snapshot: snapshot), lodgingItem.completed == true {
            newItems.append(lodgingItem)
          }
        }
        self.items = newItems
        self.tableView.reloadData()
      }
  }
  
  // MARK: UITableView Delegate methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: itemCellIdentifier)
    
    let lodgingItem = items[indexPath.row]
    
    cell.textLabel?.text = lodgingItem.name
    cell.detailTextLabel?.text = lodgingItem.addedByUser
    
//    toggleCellCheckbox(cell, isCompleted: lodgingItem.completed)
    
    return cell
  }
  
  
  
}
