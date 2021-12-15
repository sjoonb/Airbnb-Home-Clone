//
//  MapViewController.swift
//  AirBnb Home Clone
//
//  Created by 백성준 on 2021/12/13.
//

import UIKit
import MapKit
import Contacts

class MapViewController: UIViewController, MKMapViewDelegate {
  let mapView: MKMapView = MKMapView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view = mapView

    let location = CLLocationCoordinate2D(latitude: 38.18857958767892, longitude: 128.60378138910482)
    let address = [CNPostalAddressStreetKey: "181 Piccadilly, St. James's", CNPostalAddressCityKey: "London", CNPostalAddressPostalCodeKey: "W1A 1ER", CNPostalAddressISOCountryCodeKey: "GB"]

    let pin = MKPlacemark(coordinate: location, addressDictionary: address)
    
    let region = MKCoordinateRegion(
      center: pin.coordinate,
      latitudinalMeters: 200,
      longitudinalMeters: 200)
    self.mapView.setRegion(region, animated: false)
    self.mapView.addAnnotation(pin)
    
//    mapView.delegate = self
    
  }
}
