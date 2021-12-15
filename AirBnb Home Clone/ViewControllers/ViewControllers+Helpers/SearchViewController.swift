//
//  SearchViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/12/14.
//


import UIKit
import Firebase
import FirebaseDatabase
import SwiftUI


class SearchViewController: UITableViewController {
  // MARK: Constants
  
  private let itemCellIdentifier = "ItemCell"
  
  let listToUsers = "ListToUsers"
  let ref = Database.database().reference(withPath: "lodging-items")
  var refObservers: [DatabaseHandle] = []
  
//  let usersRef = Database.database().reference(withPath: "online")
//  var usersRefObservers: [DatabaseHandle] = []
  
  // MARK: Properties
  var items: [LodgingItem] = []
  var filteredItems: [LodgingItem] = []
  var user: User?
//  var onlineUserCount = UIBarButtonItem()
  var handle: AuthStateDidChangeListenerHandle?
  
  let searchBar = UISearchBar()
//  override var preferredStatusBarStyle: UIStatusBarStyle {
//    return .lightContent
//  }
  
  @objc func cancelClicked(sender: UIBarButtonItem) {
      print("Cancel clicked!")
      self.dismiss(animated: true, completion: nil)
  }

  // MARK: UIViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // SearchBar configuration
    
    navigationItem.titleView = searchBar
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(cancelClicked(sender:)))

    searchBar.delegate = self
    
    tableView.allowsMultipleSelectionDuringEditing = false
    
    let buttonItem = UIBarButtonItem(title: "hosting", style: .plain, target: self, action: #selector(hostingButtonPressed))
    buttonItem.tintColor = .systemBlue
    
    toolbarItems = [
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      buttonItem,
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    ]
        
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    tableView.addGestureRecognizer(tap)
    
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isToolbarHidden = false
    
    let completed = ref
      .queryOrdered(byChild: "isFavorite")
      .observe(.value) { snapshot in
        var newItems: [LodgingItem] = []
        for child in snapshot.children {
          if
            let snapshot = child as? DataSnapshot,
            let lodgingItem = LodgingItem(snapshot: snapshot) {
            newItems.append(lodgingItem)
          }
        }
        newItems.sort {
          $0.isFavorite && !$1.isFavorite
        }
        self.items = newItems
        self.filteredItems = newItems
        self.tableView.reloadData()
      }
      
    refObservers.append(completed)
    
    handle = Auth.auth().addStateDidChangeListener { _, user in
      guard let user = user else { return }
      self.user = user
    }
//
//      let currentUserRef = self.usersRef.child(user.uid)
//      currentUserRef.setValue(user.email)
//      currentUserRef.onDisconnectRemoveValue()
//    }
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    navigationController?.isToolbarHidden = false
    
    refObservers.forEach(ref.removeObserver(withHandle:))
    refObservers = []
//    usersRefObservers.forEach(usersRef.removeObserver(withHandle:))
//    usersRefObservers = []
//    guard let handle = handle else { return }
//    Auth.auth().removeStateDidChangeListener(handle)
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
    
    toggleFavoriteMark(cell, isFavorite: lodgingItem.isFavorite)
    
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
    tableView.deselectRow(at: indexPath, animated: true)
    guard let _ = tableView.cellForRow(at: indexPath) else { return }
    
    let lodgingItem = filteredItems[indexPath.row]
    
    let navLodgingViewController = LodgingViewController(lodgingItem: lodgingItem)
    
    
    if let sheet = navLodgingViewController.sheetPresentationController {
        sheet.detents = [ .large() ]
        sheet.prefersGrabberVisible = true
    }
    
    present(navLodgingViewController, animated: true, completion: nil)

  }
  
  func toggleFavoriteMark(_ cell: UITableViewCell, isFavorite: Bool) {
    if !isFavorite {
      cell.accessoryView = nil

    } else {
      cell.accessoryView = UIImageView(systemImageName: "heart.fill")
      cell.accessoryView?.tintColor = .systemRed

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
        let text = alert.textFields?[0].text,
        let description = alert.textFields?[1].text,
        let streetKey = alert.textFields?[2].text,
        let latitudeText = alert.textFields?[3].text,
        let longitudeText = alert.textFields?[4].text,
        let user = self.user
      else { return }
      
      if text == "" || description == "" || streetKey == "" { return  }
      
      guard
        let latitude = Double(latitudeText),
        let longitude = Double(longitudeText)
      else { return }
      
      let lodgingItem = LodgingItem(
        name: text,
        description: description,
        addedByUser: user.email ?? "",
        isVisited: false,
        streetKey: streetKey,
        latitude: latitude,
        longitude: longitude)
//        mapItem: MapItem(streetKey: streetKey, latitude: latitude, longitude: longitude))
      
      let lodgingItemRef = self.ref.child(text.lowercased())
      lodgingItemRef.setValue(lodgingItem.toAnyObject())
    }
    
    let cancelAction = UIAlertAction(
      title: "Cancel",
      style: .cancel)
    
    for _ in 1...5 {
      alert.addTextField()
    }

    alert.textFields?[0].placeholder = "name"
    alert.textFields?[1].placeholder = "description"
    alert.textFields?[2].placeholder = "streetKey"
    alert.textFields?[3].placeholder = "latitude"
    alert.textFields?[4].placeholder = "longitude"
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  
  @objc func dismissKeyboard() {
    searchBar.endEditing(true)
  }
  
}

extension SearchViewController: UISearchBarDelegate {
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
