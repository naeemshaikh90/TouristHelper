//
//  Viewport.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 09/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import ObjectMapper

class Viewport {
  var northeast : Location?
  var southwest : Location?
  
  required convenience init?(map: Map) {
    self.init()
  }
}

extension Viewport: Mappable {
  func mapping(map: Map) {
    northeast <- map["northeast"]
    southwest <- map["southwest"]
  }
}
