//
//  LocationSpec.swift
//  TouristHelperTests
//
//  Created by Naeem Shaikh on 10/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Quick
import Nimble
@testable import TouristHelper

class LocationSpec: QuickSpec {
  override func spec() {
    var location: TouristHelper.Location!
    
    describe("A Location") {
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "Location", in: testBundle)
        location = mockLoader?.map(to: Location.self)
      }
      
      it("should create a location from json file") {
        expect(location).notTo(beNil())
      }
    }
  }
}
