//
//  Location.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 09/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import ObjectMapper

class Location {
  var lat : Float?
  var lng : Float?
  
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
