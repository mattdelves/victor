//
//  PolygonSpec.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Quick
import Nimble

@testable import Victor

final class PolygonSpec: QuickSpec {
    override func spec() {
        describe("attributes") {
            let polygon = Polygon(
                attributes: [
                    "id": "path-1",
                    "points": "14.2849824 26 0.0709008076 26 0.0709008076 0.891893352 14.2849824 0.891893352 14.2849824 26"
                ],
                children: [],
                name: "polygon",
                parent: nil
            )
            it("sets the id") {
                expect(polygon.id) == "path-1"
            }
            it("sets the points") {
                expect(polygon.points) == "14.2849824 26 0.0709008076 26 0.0709008076 0.891893352 14.2849824 0.891893352 14.2849824 26"
            }
        }
    }
}
