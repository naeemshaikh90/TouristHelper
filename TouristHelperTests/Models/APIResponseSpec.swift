//
//  APIResponseSpec.swift
//  TouristHelperTests
//
//  Created by Naeem Shaikh on 10/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Quick
import Nimble
@testable import TouristHelper

class APIResponseSpec: QuickSpec {
  override func spec() {
    
    describe("An APIResponse") {
      var apiResponse: TouristHelper.APIResponse!
      
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "APIResponse", in: testBundle)
        apiResponse = mockLoader?.map(to: APIResponse.self)
      }
      
      it("should be able to create a APIResponse from json") {
        expect(apiResponse).toNot(beNil())
      }
      
      it("should have htmlAttributions") {
       expect(apiResponse.htmlAttributions).toNot(beNil())
      }
      
      it("should have nextPageToken") {
        expect(apiResponse.nextPageToken).toNot(beNil())
      }
      
      it("should have results") {
        expect(apiResponse.results).toNot(beNil())
      }
      
      it("should have status") {
        expect(apiResponse.status).toNot(beNil())
      }
    }
  }
}
