//
//  MaskSpec.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Quick
import Nimble

@testable import Victor

final class MaskSpec: QuickSpec {
    override func spec() {
        describe("attributes") {
            let mask = Mask(
                attributes: [
                    "id": "mask-2",
                    "fill": "white"
                ],
                children: [],
                name: "mask",
                parent: nil
            )
            it("sets the id") {
                expect(mask.id) == "mask-2"
            }
            it("sets the fill") {
                expect(mask.fill) == "white"
            }
        }
    }
}
