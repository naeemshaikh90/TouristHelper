//
//  Geometry.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 09/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import ObjectMapper

class Geometry {
  var location : Location?
  var viewport : Viewport?
  
  required convenience init?(map: Map) {
    self.init()
  }
}

extension Geometry: Mappable {
  func mapping(map: Map) {
    location <- map["location"]
    viewport <- map["viewport"]
  }
}
