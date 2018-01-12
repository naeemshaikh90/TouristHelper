//
//  Location.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 09/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

class Location {
  var lat: CLLocationDegrees = 0.0
  var lng: CLLocationDegrees = 0.0
  
  var location: CLLocation {
    return CLLocation(latitude: self.lat, longitude: self.lng)
  }
  
  func distance(to location: CLLocation) -> CLLocationDistance {
    return location.distance(from: self.location)
  }
  
  required convenience init?(map: Map) {
    self.init()
  }
}

extension Location: Mappable {
  func mapping(map: Map) {
    lat <- map["lat"]
    lng <- map["lng"]
  }
}
