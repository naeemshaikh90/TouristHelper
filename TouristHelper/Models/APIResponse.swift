//
//  APIResponse.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 09/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import ObjectMapper

class APIResponse {
  var htmlAttributions: [AnyObject]?
  var nextPageToken: String?
  var results: [Result]?
  var status: String?
  var errorMessage: String?
  
  required convenience init?(map: Map) {
    self.init()
  }
}

extension APIResponse: Mappable {
  func mapping(map: Map) {
    htmlAttributions <- map["html_attributions"]
    nextPageToken <- map["next_page_token"]
    results <- map["results"]
    status <- map["status"]
    errorMessage <- map["error_message"]
  }
}
