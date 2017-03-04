//
//  SVGSpec.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Quick
import Nimble

@testable import Victor

final class SVGSpec: QuickSpec {
    override func spec() {
        describe("attributes") {
            let document = SVG(
                attributes: [
                    "width": "2cm",
                    "height": "5cm",
                    "viewBox": "0 0 100 200"
                ],
                children: [],
                name: "svg",
                parent: nil
            )
            it("sets the width") {
                expect(document.width) == "2cm"
            }
            it("sets the height") {
                expect(document.height) == "5cm"
            }
            it("sets the viewBox") {
                expect(document.viewBox) == "0 0 100 200"
            }
        }
    }
}
