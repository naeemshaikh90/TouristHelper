//
//  Photo.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 09/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import ObjectMapper

class Photo {
  var height: Int?
  var htmlAttributions: [String]?
  var photoReference: String?
  var width: Int?
  
  required convenience init?(map: Map) {
    self.init()
  }
}

extension Photo: Mappable {
  func mapping(map: Map) {
    height <- map["height"]
    htmlAttributions <- map["html_attributions"]
    photoReference <- map["photo_reference"]
    width <- map["width"]
  }
}
