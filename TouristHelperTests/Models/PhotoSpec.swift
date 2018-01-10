//
//  PhotoSpec.swift
//  TouristHelperTests
//
//  Created by Naeem Shaikh on 10/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Quick
import Nimble
@testable import TouristHelper

class PhotoSpec: QuickSpec {
  override func spec() {
    var photo: TouristHelper.Photo!
    
    describe("A Photo") {
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "Photo", in: testBundle)
        photo = mockLoader?.map(to: Photo.self)
      }
      
      it("should create a photo from json file") {
        expect(photo).notTo(beNil())
      }
    }
  }
}
