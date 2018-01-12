//
//  NetworkAPIManager.swift
//  TouristHelper
//
//  Created by Naeem Shaikh on 11/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper
import Moya_ObjectMapper

extension Response {
  func removeAPIWrappers() -> Response {
    guard let json = try? self.mapJSON() as? [String: AnyObject],
      let results = json,
      let newData = try? JSONSerialization.data(withJSONObject: results,
                                                options: .prettyPrinted) else {
                                                  return self
    }
    
    let newResponse = Response(statusCode: statusCode,
                               data: newData,
                               response: response)
    return newResponse
  }
}

struct NetworkAPIManager {
  let provider: MoyaProvider<NetworkAPI>
  let disposeBag = DisposeBag()
  
  init() {
    provider = MoyaProvider<NetworkAPI>()
  }
}

extension NetworkAPIManager {
  fileprivate func requestObject<T: Mappable>(_ token: NetworkAPI, type: T.Type,
                                              completion: @escaping (T?) -> Void) {
    provider.rx.request(token)
      .mapObject(T.self)
      .subscribe { event -> Void in
        switch event {
        case .success(let parsedObject):
          completion(parsedObject)
        case .error(_):
          //debugPrint("Error: \(error)")
          completion(nil)
        }
      }.disposed(by: disposeBag)
  }
  
  fileprivate func requestArray<T: Mappable>(_ token: NetworkAPI, type: T.Type,
                                             completion: @escaping ([T]?) -> Void) {
    provider.rx.request(token)
      .debug()
      .map { response -> Response in
        return response.removeAPIWrappers()
      }
      .mapArray(T.self)
      .subscribe { event -> Void in
        switch event {
        case .success(let parsedArray):
          completion(parsedArray)
        case.error( _):
          //debugPrint(error)
          completion(nil)
        }
      }.disposed(by: disposeBag)
  }
}

protocol NetworkAPICalls {
  func getPlaces(location: String, radius: Int, placeType: String,
                 completion: @escaping ((APIResponse?) -> Void))
  func getAdditionalPlaces(pageToken: String,
                           completion: @escaping ((APIResponse?) -> Void))
}

extension NetworkAPIManager: NetworkAPICalls {
  func getPlaces(location: String, radius: Int, placeType: String,
                 completion: @escaping ((APIResponse?) -> Void)) {
    requestObject(.getPlaces(location: location, radius: radius, placeType: placeType),
                  type: APIResponse.self,
                  completion: completion)
  }
  
  func getAdditionalPlaces(pageToken: String,
                           completion: @escaping ((APIResponse?) -> Void)) {
    requestObject(.getAdditionalPlaces(pageToken: pageToken),
                  type: APIResponse.self,
                  completion: completion)
  }
}
