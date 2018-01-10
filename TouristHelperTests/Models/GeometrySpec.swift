//
//  GeometrySpec.swift
//  TouristHelperTests
//
//  Created by Naeem Shaikh on 10/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Quick
import Nimble
@testable import TouristHelper

class GeometrySpec: QuickSpec {
  override func spec() {
    var geometry: TouristHelper.Geometry!
    
    describe("A Geometry") {
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "Geometry", in: testBundle)
        geometry = mockLoader?.map(to: Geometry.self)
      }
      
      it("should create a geometry from json file") {
        expect(geometry).notTo(beNil())
      }
    }
  }
}
