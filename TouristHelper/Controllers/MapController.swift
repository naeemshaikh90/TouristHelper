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
  
  var apiManager: NetworkAPICalls = NetworkAPIManager()
  var places: [Result]?
}

extension MapController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    grabUserLocation()
  }
  
  func fetchPlaces(location: String, radius: Int, placeType: String) {
    apiManager.getPlaces(location: location, radius: radius, placeType: placeType){ response in
      if let response = response {
        if response.status == GoogleStatusCode.OK.rawValue {
          self.places = response.results
          DispatchQueue.main.async {
            self.plotPins(self.mapView)
          }
        }
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
      
      let locationToFindPlaces = ("\(location.latitude), \(location.longitude)")
      let placeTypeToFind = GooglePlaceType.point_of_interest.rawValue
      fetchPlaces(location: locationToFindPlaces, radius: kLocationRadius, placeType: placeTypeToFind)
    }
  }
}

// MARK: - GMSMapViewDelegate
extension MapController: GMSMapViewDelegate {
  func setMapFocusOnUserLocation() {
    let latitude = currentLocation.latitude
    let longitude = currentLocation.longitude
    let camera = GMSCameraPosition.camera(withLatitude: Double(latitude), longitude: Double(longitude), zoom: 15)
    mapView.camera = camera
    mapView.isMyLocationEnabled = true
  }
  
  func plotPins(_ mapView: GMSMapView) {
    if let places = places {
      for place in places {
        let lat = place.geometry?.location?.lat
        let long = place.geometry?.location?.lng
        let title = place.name
        
        if let lat = lat, let long = long {
          let marker      = GMSMarker()
          marker.position = CLLocationCoordinate2DMake(Double(lat), Double(long))
          marker.title    = title
          marker.map      = mapView
        }
      }
      connectAllPins()
    }
  }
  
  func connectAllPins() {
    let path = GMSMutablePath()
    // Source
    path.add(currentLocation)
    if let places = places {
      for place in places {
        let lat = place.geometry?.location?.lat
        let long = place.geometry?.location?.lng
         if let lat = lat, let long = long {
          path.add(CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(long)))
        }
      }
    }
    // Destination
    path.add(currentLocation)
    let polyline = GMSPolyline(path: path)
    polyline.strokeWidth = 5.0
    polyline.map = mapView
  }
}
