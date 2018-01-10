//
//  MapController.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 08/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import ObjectMapper

class MapController: UIViewController {
  
  @IBOutlet var mapView: GMSMapView!
  
  let locationManager = CLLocationManager()
  var currentLocation = CLLocationCoordinate2D()
}

extension MapController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    grabUserLocation()
    fetchPlaces()
  }
  
  func fetchPlaces() {
    Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=point_of_interest&key=AIzaSyAm5kZPbrSvRL29nmHxR7tdWWLF95gK7E8").responseJSON { response in
      
      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        let apiResponse = Mapper<APIResponse>().map(JSONString: utf8Text)
        debugPrint(apiResponse)
      }
      
    }
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
      setMapFocusOnUserLocation()
    }
  }
}

// MARK: - GMSMapViewDelegate
extension MapController: GMSMapViewDelegate {
  func setMapFocusOnUserLocation() {
    let latitude = currentLocation.latitude
    let longitude = currentLocation.longitude
    let camera = GMSCameraPosition.camera(withLatitude: Double(latitude), longitude: Double(longitude), zoom: 10)
    mapView.camera = camera
    mapView.isMyLocationEnabled = true
  }
}
