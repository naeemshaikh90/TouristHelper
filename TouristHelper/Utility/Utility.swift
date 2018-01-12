//
//  Utility.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 11/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation

let kGoogleAPIKey = "AIzaSyAm5kZPbrSvRL29nmHxR7tdWWLF95gK7E8"

let kLocationRadius = 10 * 1000 // 10 km

enum GooglePlace: String {
  case amusement_park = "amusement_park"
  case aquarium = "aquarium"
  case art_gallery = "art_gallery"
  case bar = "bar"
  case bowling_alley = "bowling_alley"
  case cafe = "cafe"
  case casino = "casino"
  case city_hall = "city_hall"
  case hindu_temple = "hindu_temple"
  case library = "library"
  case mosque = "mosque"
  case museum = "museum"
  case night_club = "night_club"
  case park = "park"
  case restaurant = "restaurant"
  case shopping_mall = "shopping_mall"
  case zoo = "zoo"
  case natural_feature = "natural_feature"
  case point_of_interest = "point_of_interest"
  
  func type() -> String {
    return self.rawValue
  }
  
  static let allValues = [amusement_park, aquarium, art_gallery, bar, bowling_alley, cafe, casino, city_hall, hindu_temple, library, mosque, museum, night_club, park, restaurant, shopping_mall, zoo, natural_feature]
}

enum GoogleStatus: String {
  //indicates that no errors occurred; the place was successfully detected and at least one result was returned.
  case OK = "OK"
  
  //indicates that the search was successful but returned no results. This may occur if the search was passed a latlng in a remote location.
  case ZERO_RESULTS = "ZERO_RESULTS"
  
  //indicates that you are over your quota.
  case OVER_QUERY_LIMIT = "OVER_QUERY_LIMIT"
  
  //indicates that your request was denied, generally because of lack of an invalid key parameter.
  case REQUEST_DENIED = "REQUEST_DENIED"
  
  //generally indicates that a required query parameter (location or radius) is missing.
  case INVALID_REQUEST = "INVALID_REQUEST"
  
  func code() -> String {
    return self.rawValue
  }
}

class Utility {
  class func googleAPIKey() -> String {
    return kGoogleAPIKey
  }
  
  class func getAllInterestingPlaceTypes() -> String {
    var placeType = ""
    for place in GooglePlace.allValues {
      placeType += place.type() + ","
    }
    return placeType
  }
  
  // https://stackoverflow.com/a/24318861/3859370
  class func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
  }
}
