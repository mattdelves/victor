//
//  ParserSpec.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Quick
import Nimble

@testable import Victor

final class ParserSpec: QuickSpec {
    override func spec() {
        describe("file") {
            it("preparation") {
                let parser = Parser(file: "hithere")
                expect(parser.location) == "hithere"
            }
        }
        context("parsing") {
            let filePath = Bundle(for: type(of: self)).path(forResource: "simple_rect", ofType: "svg")!
            let parser = Parser(file: "file://\(filePath)")

            it("returns SVG document") {
                expect(parser.parse()).notTo(beNil())
            }
            it("has some children") {
                expect(parser.parse()?.children.count) == 5
            }
        }
        context("parsing groups") {
            let filePath = Bundle(for: type(of: self)).path(forResource: "group", ofType: "svg")!
            let parser = Parser(file: "file://\(filePath)")
            let document = parser.parse()!
            let groups = document.children.filter { $0 is Group }

            it("has 2 groups") {
                expect(groups.count) == 2
            }
            it("groups have rects") {
                let first = groups.first as! Group
                expect(first.children.count) == 2
            }
        }
        context("parsing with transforms") {
            let filePath = Bundle(for: type(of: self)).path(forResource: "rect02", ofType: "svg")!
            let parser = Parser(file: "file://\(filePath)")
            let document = parser.parse()!

            it("3 children") {
                expect(document.children.count) == 3
            }
        }
        describe("riko") {
            let filePath = Bundle(for: type(of: self)).path(forResource: "riko", ofType: "svg")!
            let parser = Parser(file: "file://\(filePath)")
            let document = parser.parse()!
            context("defs") {
                it("has 1 defs element") {
                    let defs = document.children.filter { $0 is Defs }
                    expect(defs.count) == 1
                }
            }
            context("polygons") {
                it("has 1 polygon element") {
                    let polygons = document.children.filter { $0 is Polygon }
                    expect(polygons.count) == 1
                }
            }
            context("path") {
                it("has 32 path elements") {
                    let paths = document.children.filter { $0 is Path }
                    expect(paths.count) == 32
                }
            }
            context("groups") {
                let groups = document.children.filter { $0 is Group }
                let group = groups.first as! Group

                it("has 1 group element") {
                    expect(groups.count) == 1
                }
                it("the group has a mask") {
                    let innerGroup = group.children.filter { $0 is Group }.first as! Group
                    let masks = innerGroup.children.filter { $0 is Mask }
                    expect(masks.count) == 1
                }
                it("has path elements") {
                    let paths = group.children.filter { $0 is Path }
                    expect(paths.count) == 13
                }
            }
        }
    }
}
