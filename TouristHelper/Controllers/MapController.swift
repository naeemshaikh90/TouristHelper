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
  var isWebServiceCalled = false
  var places = [Result]()
}

// MARK: - View Lifecycle
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
      setMapFocusOnUserLocation()
      
      // To call web service only once
      if !isWebServiceCalled {
        isWebServiceCalled = !isWebServiceCalled
        callFetchPlaces(location: location)
      }
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
    mapView.settings.myLocationButton = true
  }
  
  func plotPins(_ mapView: GMSMapView) {
    var bounds = GMSCoordinateBounds()
    for place in places {
      let lat = place.geometry?.location?.lat
      let long = place.geometry?.location?.lng
      let title = place.name
      let vicinity = place.vicinity
      
      if let lat = lat, let long = long {
        let marker      = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(Double(lat), Double(long))
        marker.title    = title
        marker.snippet  = vicinity
        marker.map      = mapView
        bounds = bounds.includingCoordinate(marker.position)
      }
      connectAllPins()
      
      // Set zoom level to cover all pins
      let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
      mapView.animate(with: update)
    }
  }
  
  func connectAllPins() {
    let path = GMSMutablePath()
    // Source
    path.add(currentLocation)
    for place in places {
      let lat = place.geometry?.location?.lat
      let long = place.geometry?.location?.lng
      if let lat = lat, let long = long {
        path.add(CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(long)))
      }
    }
    // Destination
    path.add(currentLocation)
    let polyline = GMSPolyline(path: path)
    polyline.strokeWidth = 5.0
    polyline.map = mapView
  }
}

// MARK: - Networking
extension MapController {
  func callFetchPlaces(location: CLLocationCoordinate2D) {
    let locationToFindPlaces = ("\(location.latitude), \(location.longitude)")
    let placeTypeToFind = GooglePlace.restaurant.type()
    fetchPlaces(location: locationToFindPlaces, radius: kLocationRadius, placeType: placeTypeToFind)
  }
  
  func fetchPlaces(location: String, radius: Int, placeType: String) {
    apiManager.getPlaces(location: location, radius: radius, placeType: placeType){ response in
      if let response = response {
        Utility.delay(1.0) {
          self.parseAPIResponse(response: response)
        }
      }
    }
  }
  
  func fetchAdditionalPlaces(pageToken: String) {
    apiManager.getAdditionalPlaces(pageToken: pageToken) { response in
      if let response = response {
        Utility.delay(1.0) {
          self.parseAPIResponse(response: response)
        }
      }
    }
  }
  
  func parseAPIResponse(response: APIResponse) {
    if response.status == GoogleStatus.OK.code() {
      if let places = response.results, places.count > 0 {
        for place in places {
          self.places.append(place)
        }
        DispatchQueue.main.async {
          self.plotPins(self.mapView)
          
          if let nextPageToken = response.nextPageToken {
            // There is a short delay between when a 'next_page_token' is issued
            Utility.delay(2.0) {
              self.fetchAdditionalPlaces(pageToken: nextPageToken)
            }
          }
          debugPrint("Total Count: \(self.places.count)")
        }
      }
    } else {
      if let error = response.status {
        debugPrint("Function: \(#function), Error: \(error)")
        if let errorMessage = response.errorMessage {
          debugPrint("Function: \(#function), Error Message: \(errorMessage)")
        }
      }
    }
  }
}
