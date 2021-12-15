//
//  LodgingView.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/12/14.
//

import UIKit
import Anchorage
import FirebaseDatabase
import MapKit
import Contacts

protocol LodgingViewDelegate: AnyObject {
  func toggleFavorite()
}

class LodgingView: ProgrammaticView {
  
  weak var delegate: LodgingViewDelegate?
  
  private let numberOfSeparators = 2
  
  private let scrollView: UIScrollView = UIScrollView()
  private let stackView: UIStackView = UIStackView()
  private var separators: [UIView] = []
  private let favoriteButton: UIButton = UIButton()
  private let descriptionLabel: UILabel = UILabel()
  private let titleLabel: UILabel = UILabel()
  private let mapViewTitleLabel: UILabel = UILabel()
  private let mapView: MKMapView = MKMapView()
  private let footerView: UIView = UIView()
  
  private var isFavorite: Bool?

  override func configure() {
    
    backgroundColor = .white
    
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 0
    stackView.backgroundColor = .white
    
    for _ in 1...numberOfSeparators {
      let separator = UIView()
      separator.backgroundColor = .quaternaryLabel
      separators.append(separator)
    }
    
    titleLabel.text = "#1101 속초 오늘 멋진날 #1101 속초 오늘 멋진날 #1101 속초 오늘 멋진날 #1101 속초 오늘 멋진날 "
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    
    favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    favoriteButton.tintColor = .systemRed
    favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    
    descriptionLabel.text = ""
    descriptionLabel.numberOfLines = 0
    
    mapViewTitleLabel.text = "호스팅 지역"
    mapViewTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    
    
//    let location = CLLocationCoordinate2D(latitude: 38.18857958767892, longitude: 128.60378138910482)
//    let address = [CNPostalAddressStreetKey: "181 Piccadilly, St. James's", CNPostalAddressCityKey: "London", CNPostalAddressPostalCodeKey: "W1A 1ER", CNPostalAddressISOCountryCodeKey: "GB"]
//
//    let pin = MKPlacemark(coordinate: location, addressDictionary: address)
//
//    let region = MKCoordinateRegion(
//      center: pin.coordinate,
//      latitudinalMeters: 200,
//      longitudinalMeters: 200)
//    self.mapView.setRegion(region, animated: false)
//    self.mapView.addAnnotation(pin)
//
    mapView.backgroundColor = .white
    
    mapView.layer.cornerRadius = 10.0
    mapView.layer.shadowColor = UIColor.gray.cgColor
    mapView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    mapView.layer.shadowRadius = 6.0
    mapView.layer.shadowOpacity = 0.7
    
    
  }
  
  override func constrain() {
    addSubview(scrollView)
    
    scrollView.topAnchor == topAnchor
    scrollView.horizontalAnchors == horizontalAnchors
    scrollView.bottomAnchor == bottomAnchor
    
    scrollView.addSubview(stackView)
    
    stackView.topAnchor == scrollView.topAnchor
    stackView.bottomAnchor == scrollView.bottomAnchor
    stackView.leadingAnchor == scrollView.leadingAnchor
    stackView.trailingAnchor == scrollView.trailingAnchor
    
    stackView.widthAnchor == scrollView.widthAnchor
    
    stackView.addSubviews(titleLabel, favoriteButton, descriptionLabel ,mapViewTitleLabel, mapView, footerView)
    separators.forEach { separator in
      stackView.addSubview(separator)
      separator.centerXAnchor == stackView.centerXAnchor
      separator.heightAnchor == 1
      separator.widthAnchor == stackView.widthAnchor - 60
      
    }
    
    titleLabel.topAnchor == stackView.topAnchor + 30
    titleLabel.leadingAnchor == stackView.leadingAnchor + 30
    titleLabel.trailingAnchor == stackView.trailingAnchor - 30
    
    favoriteButton.centerYAnchor == titleLabel.centerYAnchor
    favoriteButton.trailingAnchor == stackView.trailingAnchor - 30
    
    separators[0].topAnchor == titleLabel.bottomAnchor + 30
    
    descriptionLabel.topAnchor == separators[0].bottomAnchor + 30
    descriptionLabel.leadingAnchor == stackView.leadingAnchor + 30
    descriptionLabel.trailingAnchor == stackView.trailingAnchor - 30
    
    separators[1].topAnchor == descriptionLabel.bottomAnchor + 30
    
    mapViewTitleLabel.topAnchor == separators[1].bottomAnchor + 30
    mapViewTitleLabel.leadingAnchor == stackView.leadingAnchor + 30
    
    mapView.topAnchor == mapViewTitleLabel.bottomAnchor + 30
    mapView.leadingAnchor == stackView.leadingAnchor + 30
    mapView.trailingAnchor == stackView.trailingAnchor - 30
    mapView.heightAnchor == 200
    
    stackView.bottomAnchor == mapView.bottomAnchor + 30
    
  }
  
  func configure(with content: LodgingItem?) {
    titleLabel.text = content?.name
    descriptionLabel.text = content?.description
    isFavorite = content?.isFavorite

    if isFavorite != nil {
      toggleFavoriteButton()
    }
    
    configureMapView(with: content?.mapItem)

  }
  
  // MARK: - Private Helpers
  
  private func configureMapView(with mapItem: MapItem?) {
    
    guard let mapItem = mapItem else { return }
    
    let location = CLLocationCoordinate2D(latitude: mapItem.latitude, longitude: mapItem.longitude)
    let address = [CNPostalAddressStreetKey: mapItem.streetKey, CNPostalAddressCountryKey: "/ Republic Of Korea"]
    
    let pin = MKPlacemark(coordinate: location, addressDictionary: address)
    
    let region = MKCoordinateRegion(
      center: pin.coordinate,
      latitudinalMeters: 200,
      longitudinalMeters: 200)
    self.mapView.setRegion(region, animated: false)
    self.mapView.addAnnotation(pin)
    
  }
  
  private func toggleFavoriteButton() {
    favoriteButton.setImage(isFavorite! ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
  }
  
  @objc func favoriteButtonTapped() {
    if isFavorite != nil {
      isFavorite = !isFavorite!
      toggleFavoriteButton()
      delegate?.toggleFavorite()
    }
  }
  
}
