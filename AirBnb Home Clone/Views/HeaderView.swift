//
//  HeaderView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/09/13.
//

import Anchorage
import UIKit

protocol HeaderViewDelegate: AnyObject   {
  func updateStatusBarStyle(to style: UIStatusBarStyle)
  func openSheet()
}



class HeaderView: ProgrammaticView {
  
  weak var delegate: HeaderViewDelegate?
  
  private var statusBarStyle: UIStatusBarStyle = .lightContent {
    didSet { delegate?.updateStatusBarStyle(to: statusBarStyle) }
  }
  
  private let card = UIView()
  private let imageView = UIImageView()
  private let searchContainer = UIView()
  private let searchBar = UIButton(type: .roundedRect)
  private let titleLabel = UITextView()
  private let button = UIButton(type: .roundedRect)
  private let separator = UIView()
  
  private lazy var minHeight: CGFloat = { 44 + 12 + 12 + safeAreaInsets.top }()
  private let maxHeight: CGFloat = 550
  private var maxTopSpace: CGFloat = 40
  private var heightConstraint = NSLayoutConstraint()
  private var topSpaceConstraint = NSLayoutConstraint()
  
  override func configure() {
    backgroundColor = .black
    
    
    card.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    card.layer.cornerRadius = 20
    card.layer.masksToBounds = true
    
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "background")
    
    searchContainer.backgroundColor = .systemBackground
    searchContainer.setBackgroundAlpha(0)
    
    
    searchBar.backgroundColor = .secondarySystemBackground
    searchBar.layer.cornerRadius = 22
    searchBar.setTitle("어디로 여행가세요?", for: .normal)
    searchBar.setTitleColor(.label, for: .normal)
    searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    searchBar.tintColor = .systemPink
    searchBar.titleLabel?.font = .custom(style: .button)
    searchBar.imageView?.contentMode = .scaleAspectFit
    searchBar.imageEdgeInsets = .init(top: 14, left: 0, bottom: 14, right: 4)
    searchBar.addTarget(self, action: #selector(searchBarTapped), for: .touchUpInside)

    titleLabel.text = "에어비앤비가\n여행지를 찾아드릴게요!"
    titleLabel.textColor = .black
    titleLabel.font = .custom(style: .headline)
    titleLabel.font = titleLabel.font?.withSize(18)
    titleLabel.isScrollEnabled = false
    titleLabel.isEditable = false
    titleLabel.isSelectable = false
    titleLabel.backgroundColor = .clear
    
    button.backgroundColor = .white
    button.layer.cornerRadius = 24
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 0, height: 3.0)
    button.layer.shadowRadius = 2
    button.layer.borderWidth = 0.1
    button.layer.borderColor = UIColor.gray.cgColor
    button.setTitle("유연한 검색", for: .normal)
    button.setTitleColor(.purple, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    button.contentEdgeInsets = .init(top: 14, left: 30, bottom: 14, right: 30)
    
    separator.backgroundColor = .quaternaryLabel
    
  }
  
  override func constrain() {
    addSubviews(card, titleLabel, button, separator)
    card.addSubviews(imageView, searchContainer)
    searchContainer.addSubview(searchBar)
    
    heightConstraint = heightAnchor == maxHeight
    //
    topSpaceConstraint = card.topAnchor == topAnchor + maxTopSpace
    card.topAnchor == topAnchor + 40
    card.horizontalAnchors == horizontalAnchors
    card.bottomAnchor == bottomAnchor
    
    imageView.edgeAnchors == card.edgeAnchors
    
    searchContainer.topAnchor == card.topAnchor
    searchContainer.horizontalAnchors == card.horizontalAnchors
    searchContainer.heightAnchor >= 60
    
    searchBar.heightAnchor == 44
    searchBar.topAnchor >= searchContainer.topAnchor + 24
    searchBar.topAnchor >= safeAreaLayoutGuide.topAnchor + 12
    searchBar.horizontalAnchors == searchContainer.horizontalAnchors + 24
    searchBar.bottomAnchor == searchContainer.bottomAnchor - 12
    
    titleLabel.textAlignment = NSTextAlignment.center
    titleLabel.topAnchor == safeAreaLayoutGuide.topAnchor + 240
    titleLabel.widthAnchor == widthAnchor
    
    button.topAnchor == titleLabel.bottomAnchor + 8
    button.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
    //        button.widthAnchor == titleLabel.widthAnchor
    
    separator.heightAnchor == 1
    separator.horizontalAnchors == horizontalAnchors
    separator.bottomAnchor == bottomAnchor
  }
  
  override func safeAreaInsetsDidChange() {
    maxTopSpace = 40 + safeAreaInsets.top
    topSpaceConstraint.constant = maxTopSpace
  }
}

extension HeaderView {

  private var currentOffset: CGFloat {
    get { heightConstraint.constant }
    set { animate(to: newValue) }
  }
  
  func updateHeader(newY: CGFloat, oldY: CGFloat) -> CGFloat {
    
    let delta = newY - oldY
    
    let isMovingUp = delta > 0
    let isInContent = newY > 0
    let hasRoomToCollapse = currentOffset > minHeight
    let shouldCollapse = isMovingUp && isInContent && hasRoomToCollapse
    
    let isMovingDown = delta < 0
    let isBeyondContent = newY < 0
    let hasRoomToExpand = currentOffset < maxHeight
    let shouldExpand = isMovingDown && isBeyondContent && hasRoomToExpand
    
    if shouldCollapse || shouldExpand {
      currentOffset -= delta
      return newY - delta
    }
    
    if shouldCollapse {
      currentOffset -= delta
      return newY - delta
    }
    
    return newY
  }
  
  private func animate(to value: CGFloat) {
    let clamped = max(min(value, maxHeight), minHeight)
    heightConstraint.constant = clamped
    
    let normalized = (value - minHeight) / (maxHeight - minHeight)
    switch normalized {
    case ..<0.5:
      animateToFifty(normalized)
    default:
      animateToOneHundread(normalized)
    }
    
  }
  
  private func animateToFifty(_ normalized: CGFloat) {
    let newTop = normalized * 2 * maxTopSpace
    topSpaceConstraint.constant = newTop
    searchContainer.setBackgroundAlpha(1 - normalized * 2)
    if newTop < 24 && statusBarStyle != .darkContent {
      statusBarStyle = .darkContent
    } else if newTop > 24 && statusBarStyle != .lightContent {
      statusBarStyle = .lightContent
    }
  }
  
  private func animateToOneHundread(_ normalized: CGFloat) {
    topSpaceConstraint.constant = maxTopSpace
    searchContainer.setBackgroundAlpha(0)
  }
  
  
}

extension HeaderView {
  @objc func searchBarTapped() {
    delegate?.openSheet()
  }
}
