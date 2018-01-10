//
//  ViewportSpec.swift
//  TouristHelperTests
//
//  Created by Naeem Shaikh on 10/01/18.
//  Copyright © 2018 Naeem Shaikh. All rights reserved.
//

import Quick
import Nimble
@testable import TouristHelper

class ViewportSpec: QuickSpec {
  override func spec() {
    var viewport: TouristHelper.Viewport!
    
    describe("A Viewport") {
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "Viewport", in: testBundle)
        viewport = mockLoader?.map(to: Viewport.self)
      }
      
      it("should create a viewport from json file") {
        expect(viewport).notTo(beNil())
      }
    }
  }
}
