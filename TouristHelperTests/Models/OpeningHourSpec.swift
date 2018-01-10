//
//  OpeningHourSpec.swift
//  TouristHelperTests
//
//  Created by Naeem Shaikh on 10/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Quick
import Nimble
@testable import TouristHelper

class OpeningHourSpec: QuickSpec {
  override func spec() {
    var openingHour: TouristHelper.OpeningHour!
    
    describe("An OpeningHour") {
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "OpeningHour", in: testBundle)
        openingHour = mockLoader?.map(to: OpeningHour.self)
      }
      
      it("should create an openingHour from json file") {
        expect(openingHour).notTo(beNil())
      }
    }
  }
}
