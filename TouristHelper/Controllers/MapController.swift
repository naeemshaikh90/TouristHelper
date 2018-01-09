//
//  MapController.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 08/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import UIKit
import GoogleMaps

class MapController: UIViewController {
  
  let locationManager = CLLocationManager()
  var currentLocation = CLLocationCoordinate2D()
}

extension MapController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    grabUserLocation()
  }
}

// MARK: - CLLocationManagerDelegate
extension MapController: CLLocationManagerDelegate {
  
  func grabUserLocation() {
    locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
      locationManager.startUpdatingLocation()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locationValue = manager.location?.coordinate
    if let location = locationValue {
      print("Current Location: \(location.latitude), \(location.longitude)")
      currentLocation = location
      locationManager.stopUpdatingLocation()
    }
  }
}
