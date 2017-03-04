//
//  RectSpec.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Quick
import Nimble

@testable import Victor

final class RectSpec: QuickSpec {
    override func spec() {
        describe("attributes") {
            let rect = Rect(
                attributes: [
                    "width": "2cm",
                    "height": "5cm",
                    "x": "12",
                    "y": "15"
                ],
                children: [],
                name: "rect",
                parent: nil
            )
            it("sets the width") {
                expect(rect.width) == "2cm"
            }
            it("sets the height") {
                expect(rect.height) == "5cm"
            }
            it("sets the x") {
                expect(rect.x) == "12"
            }
            it("sets the y") {
                expect(rect.y) == "15"
            }
        }
    }
}
