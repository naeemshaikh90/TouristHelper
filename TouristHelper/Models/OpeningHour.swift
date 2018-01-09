//
//  OpeningHour.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 09/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import ObjectMapper

class OpeningHour {
  var openNow : Bool?
  var weekdayText : [AnyObject]?
  
  required convenience init?(map: Map) {
    self.init()
  }
}

extension OpeningHour: Mappable {
  func mapping(map: Map) {
    openNow <- map["open_now"]
    weekdayText <- map["weekday_text"]
  }
}
