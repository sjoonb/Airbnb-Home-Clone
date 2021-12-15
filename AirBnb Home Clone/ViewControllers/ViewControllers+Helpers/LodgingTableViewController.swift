//
//  LodgingTableViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/12/14.
//

import UIKit
import Firebase
import FirebaseDatabase

class LodgingTableViewController: UITableViewController {
  
  let ref = Database.database().reference(withPath: "lodging-items")
  
  private let itemCellIdentifier = "ItemCell"

  var items: [LodgingItem] = []
  
  init() {
    super.init(style: .grouped)
    tableView.backgroundColor = .white
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isToolbarHidden = false
  }
  
  // MARK: - TableViewDelegate
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: itemCellIdentifier)
    
    let lodgingItem = items[indexPath.row]
    
    cell.textLabel?.text = lodgingItem.name
    cell.detailTextLabel?.text = lodgingItem.addedByUser
        
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let lodgingItem = items[indexPath.row]
    
    let navLodgingViewController = LodgingViewController(lodgingItem: lodgingItem)
    
    
    if let sheet = navLodgingViewController.sheetPresentationController {
        sheet.detents = [ .large() ]
        sheet.prefersGrabberVisible = true
    }
    
    present(navLodgingViewController, animated: true, completion: nil)
  }
}
