//
//  Result.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 09/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import ObjectMapper

class Result{
  var geometry: Geometry?
  var icon: String?
  var id: String?
  var name: String?
  var openingHours: OpeningHour?
  var photos: [Photo]?
  var placeId: String?
  var priceLevel: Int?
  var rating: Int?
  var reference: String?
  var scope: String?
  var types: [String]?
  var vicinity: String?
  
  required convenience init?(map: Map) {
    self.init()
  }
}

extension Result: Mappable {
  func mapping(map: Map) {
    geometry <- map["geometry"]
    icon <- map["icon"]
    id <- map["id"]
    name <- map["name"]
    openingHours <- map["opening_hours"]
    photos <- map["photos"]
    placeId <- map["place_id"]
    priceLevel <- map["price_level"]
    rating <- map["rating"]
    reference <- map["reference"]
    scope <- map["scope"]
    types <- map["types"]
    vicinity <- map["vicinity"]
  }
}
