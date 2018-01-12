//
//  NetworkAPI.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 11/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import Moya

enum NetworkAPI {
  case getPlaces(location: String, radius: Int, placeType: String)
  case getAdditionalPlaces(pageToken: String)
}

extension NetworkAPI: TargetType {
  // The target's base `URL`.
  var baseURL: URL {
    switch self {
    case .getPlaces, .getAdditionalPlaces:
      return URL(string: "https://maps.googleapis.com/maps/api")!
    }
  }
  
  // The path to be appended to `baseURL` to form the full `URL`.
  var path: String {
    switch self {
    case .getPlaces, .getAdditionalPlaces:
      return "/place/nearbysearch/json"
    }
  }
  
  // The HTTP method used in the request.
  var method: Moya.Method {
    switch self {
    case .getPlaces, .getAdditionalPlaces:
      return .get
    }
  }
  
  // The parameters to be incoded in the request.
  var parameters: [String: Any]? {
    switch self {
    case let .getPlaces(location, radius, placeType):
      //return ["location": location, "rankby": "distance", "type": placeType, "pagetoken": pageToken, "key": Utility.googleAPIKey()]
      return ["location": location, "radius": radius, "type": placeType, "key": Utility.googleAPIKey()]
    case .getAdditionalPlaces(let pageToken):
      return ["pagetoken": pageToken, "key": Utility.googleAPIKey()]
    }
  }
  
  // Provides stub data for use in testing.
  var sampleData: Data {
    switch self {
    case .getPlaces, .getAdditionalPlaces:
      return Data()
    }
  }
  
  // The type of HTTP task to be performed.
  var task: Task {
    switch self {
      case .getPlaces, .getAdditionalPlaces:
      return .requestParameters(parameters: parameters!, encoding: URLEncoding.default)
    }
  }
  
  // The headers to be used in the request.
  var headers: [String : String]? {
    switch self {
    case .getPlaces, .getAdditionalPlaces:
      return ["Content-type": "application/json"]
    }
  }
}
