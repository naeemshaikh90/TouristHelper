//
//  ResultSpec.swift
//  TouristHelperTests
//
//  Created by Naeem Shaikh on 10/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Quick
import Nimble
@testable import TouristHelper

class ResultSpec: QuickSpec {
  override func spec() {
    
    describe("A Result") {
      var result: TouristHelper.Result!
      
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "Result", in: testBundle)
        result = mockLoader?.map(to: Result.self)
      }
      
      it("should create a result from json file") {
        expect(result).notTo(beNil())
      }
      
      it("should have geometry") {
        expect(result.geometry).toNot(beNil())
      }
      
      it("should have icon") {
        expect(result.icon).toNot(beNil())
      }
      
      it("should have id") {
        expect(result.id).toNot(beNil())
      }
      
      it("should have name") {
        expect(result.name).toNot(beNil())
      }
      
      it("should have openingHours") {
        expect(result.openingHours).toNot(beNil())
      }
      
      it("should have placeId") {
        expect(result.placeId).toNot(beNil())
      }
      
      it("should have priceLevel") {
        expect(result.priceLevel).toNot(beNil())
      }
      
      it("should have rating") {
        expect(result.rating).toNot(beNil())
      }
      
      it("should have reference") {
        expect(result.reference).toNot(beNil())
      }
      
      it("should have scope") {
        expect(result.scope).toNot(beNil())
      }
      
      it("should have types") {
        expect(result.types).toNot(beNil())
      }
      
      it("should have vicinity") {
        expect(result.vicinity).toNot(beNil())
      }
    }
  }
}
