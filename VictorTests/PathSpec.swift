//
//  PathSpec.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Quick
import Nimble

@testable import Victor

final class PathSpec: QuickSpec {
    override func spec() {
        describe("attributes") {
            let path = Path(
                attributes: [
                    "d": "M156.882662,276.778654 L158.836361,281.182312 L153.541468,280.837803 C153.460371,283.106035 155.021856,285.72535 157.813065,287.553085 C161.736682,290.122433 171.255988,289.312444 171.255988,289.312444 C171.255988,289.312444 169.271325,280.971925 165.346233,278.402577 C162.555024,276.574842 159.28608,276.031781 156.882662,276.778654",
                    "id": "Fill-1",
                    "stroke": "none",
                    "fill": "#FFFFFF",
                    "fill-rule": "evenodd",
                    "mask": "url(#mask-2)"
                ],
                children: [],
                name: "path",
                parent: nil
            )
            it("sets the data") {
                expect(path.data) == "M156.882662,276.778654 L158.836361,281.182312 L153.541468,280.837803 C153.460371,283.106035 155.021856,285.72535 157.813065,287.553085 C161.736682,290.122433 171.255988,289.312444 171.255988,289.312444 C171.255988,289.312444 169.271325,280.971925 165.346233,278.402577 C162.555024,276.574842 159.28608,276.031781 156.882662,276.778654"
            }
            it("sets the id") {
                expect(path.id) == "Fill-1"
            }
            it("sets the stroke") {
                expect(path.stroke) == "none"
            }
            it("sets the fill") {
                expect(path.fill) == "#FFFFFF"
            }
            it("sets the fill rule") {
                expect(path.fillRule) == "evenodd"
            }
            it("sets the mask") {
                expect(path.mask) == "url(#mask-2)"
            }
        }
    }
}
