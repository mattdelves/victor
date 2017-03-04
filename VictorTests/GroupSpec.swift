//
//  GroupSpec.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Quick
import Nimble

@testable import Victor

final class GroupSpec: QuickSpec {
    override func spec() {
        describe("attributes") {
            let group = Group(
                attributes: [
                    "id": "Something",
                    "fill": "red"
                ],
                children: [],
                name: "g",
                parent: nil
            )
            it("sets the id") {
                expect(group.id) == "Something"
            }
            it("sets the fill") {
                expect(group.fill) == "red"
            }
        }
    }
}
