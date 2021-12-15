//
//  LodgingViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/12/12.
//

import UIKit
import FirebaseDatabase

class LodgingViewController: UIViewController, LodgingViewDelegate {
  
  private lazy var contentView: LodgingView = .init()
  
  private var lodgingItem: LodgingItem!
  var ref: DatabaseReference!
  var refObservers: [DatabaseHandle] = []
  
  init(lodgingItem: LodgingItem) {
    super.init(nibName: nil, bundle: nil)
    self.ref = lodgingItem.ref
    self.lodgingItem = lodgingItem
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life Cycles
  
  override func loadView() {
    view = contentView
    contentView.delegate = self
    
  }
  
  override func viewDidLoad() {
    contentView.configure(with: self.lodgingItem)
    contentView.delegate = self

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let completed = ref.observe(.value) { snapshot in
      let lodgingItem = LodgingItem(snapshot: snapshot)
      self.lodgingItem = lodgingItem
    }
    refObservers.append(completed)
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    
    refObservers.forEach(ref.removeObserver(withHandle:))
    refObservers = []
    
  }
  
  // MARK: - LodgingViewDelegate
  
  func toggleFavorite() {
    let toggledIsFavorite = !lodgingItem.isFavorite
    
    lodgingItem.ref?.updateChildValues(["isFavorite": toggledIsFavorite])

  }
  

}


class TempViewController: UITableViewController {
  private let itemCellIdentifier = "ItemCell"
  
  private var lodgingItem: LodgingItem!
  var ref: DatabaseReference!
  var refObservers: [DatabaseHandle] = []
  
  init(lodgingItem: LodgingItem) {
    super.init(style: .plain)
    self.ref = lodgingItem.ref
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let completed = ref.observe(.value) { snapshot in
      let lodgingItem = LodgingItem(snapshot: snapshot)
      self.lodgingItem = lodgingItem
    }
    refObservers.append(completed)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    
    refObservers.forEach(ref.removeObserver(withHandle:))
    refObservers = []
    
  }
  
  // MARK: - UITableView Delegate methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: itemCellIdentifier)
    
    var content = cell.defaultContentConfiguration()
    content.text = "Toggle WishList"
    content.textProperties.color = .systemBlue
    
    cell.contentConfiguration = content
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let toggledCompletion = !lodgingItem.isFavorite
    
    lodgingItem.ref?.updateChildValues(["isFavorite": toggledCompletion])
    
  }
  
} 
