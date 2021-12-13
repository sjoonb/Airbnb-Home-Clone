//
//  TravelViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/11/07.
//

import UIKit
import Firebase
import FirebaseDatabase

class PreTravelViewController: PreLoginViewController<PreLoginView> {
  override func updateContent() {
    let loginContent = LoginSection.travelView.stubData()
    contentView.configure(with: loginContent)
  }
}



class TravelViewController: UITableViewController {
  // MARK: Constants
  
  private let itemCellIdentifier = "ItemCell"
  
  let listToUsers = "ListToUsers"
  let ref = Database.database().reference(withPath: "lodging-items")
  var refObservers: [DatabaseHandle] = []
  
  let usersRef = Database.database().reference(withPath: "online")
  var usersRefObservers: [DatabaseHandle] = []
  
  // MARK: Properties
  var items: [LodgingItem] = []
  var filteredItems: [LodgingItem] = []
  var user: User?
  var onlineUserCount = UIBarButtonItem()
  var handle: AuthStateDidChangeListenerHandle?
  
  let searchBar = UISearchBar()
//  override var preferredStatusBarStyle: UIStatusBarStyle {
//    return .lightContent
//  }
  
  // MARK: UIViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // SearchBar configuration
    
    navigationItem.titleView = searchBar
    searchBar.delegate = self
    
    tableView.allowsMultipleSelectionDuringEditing = false
    
    let buttonItem = UIBarButtonItem(title: "hosting", style: .plain, target: self, action: #selector(hostingButtonPressed))
    buttonItem.tintColor = .systemBlue
    
    toolbarItems = [
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      buttonItem,
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    ]
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isToolbarHidden = false
    
    let completed = ref
//      .queryOrdered(byChild: "completed")
      .observe(.value) { snapshot in
        var newItems: [LodgingItem] = []
        for child in snapshot.children {
          if
            let snapshot = child as? DataSnapshot,
            let lodgingItem = LodgingItem(snapshot: snapshot) {
            newItems.append(lodgingItem)
          }
        }
        self.items = newItems
        self.filteredItems = newItems
        self.tableView.reloadData()
      }
    refObservers.append(completed)
    
    handle = Auth.auth().addStateDidChangeListener { _, user in
      guard let user = user else { return }
      self.user = user
      
      let currentUserRef = self.usersRef.child(user.uid)
      currentUserRef.setValue(user.email)
      currentUserRef.onDisconnectRemoveValue()
    }
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    navigationController?.isToolbarHidden = false
    
    refObservers.forEach(ref.removeObserver(withHandle:))
    refObservers = []
    usersRefObservers.forEach(usersRef.removeObserver(withHandle:))
    usersRefObservers = []
    guard let handle = handle else { return }
    Auth.auth().removeStateDidChangeListener(handle)
  }
  
  // MARK: UITableView Delegate methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: itemCellIdentifier)
    
    let lodgingItem = filteredItems[indexPath.row]
    
    cell.textLabel?.text = lodgingItem.name
    cell.detailTextLabel?.text = lodgingItem.addedByUser
    
    toggleCellCheckbox(cell, isCompleted: lodgingItem.completed)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let lodgingItem = filteredItems[indexPath.row]
      lodgingItem.ref?.removeValue()
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    guard let cell = tableView.cellForRow(at: indexPath) else { return }
    let lodgingItem = filteredItems[indexPath.row]
//    let toggledCompletion = !lodgingItem.completed
//    toggleCellCheckbox(cell, isCompleted: toggledCompletion)
    let navController = UINavigationController(rootViewController: LodgingViewController(lodgingItem: lodgingItem))
    navigationController?.present(navController, animated: true, completion: nil)

//    lodgingItem.ref?.updateChildValues(["completed": toggledCompletion])
  }
  
  func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
    if !isCompleted {
      cell.accessoryType = .none
      cell.textLabel?.textColor = .black
      cell.detailTextLabel?.textColor = .black
    } else {
      cell.accessoryType = .checkmark
      cell.textLabel?.textColor = .gray
      cell.detailTextLabel?.textColor = .gray
    }
  }
  
  // MARK: Add Item
  @objc private func hostingButtonPressed() {
    let alert = UIAlertController(
      title: "Lodging Item",
      message: "Add an Item",
      preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
      guard
        let textField = alert.textFields?.first,
        let text = textField.text,
        let user = self.user
      else { return }
      
      let lodgingItem = LodgingItem(
        name: text,
        addedByUser: user.email ?? "",
        completed: false)
      
      let lodgingItemRef = self.ref.child(text.lowercased())
      lodgingItemRef.setValue(lodgingItem.toAnyObject())
    }
    
    let cancelAction = UIAlertAction(
      title: "Cancel",
      style: .cancel)
    
    alert.addTextField()
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
}

extension TravelViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filteredItems = []
    
    if searchText == "" {
      filteredItems = items
    }
    else {
      items.forEach { item in
        if item.name.lowercased().contains(searchText.lowercased()) {
          filteredItems.append(item)
        }
      }
    }
    self.tableView.reloadData()
  }
  
}
