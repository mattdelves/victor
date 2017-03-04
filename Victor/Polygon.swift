//
//  Polygon.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

final public class Polygon: Node {
    public var attributes: [String : String]
    public var children: [Node]
    public var name: String
    public weak var parent: Node?

    public enum Attributes: String {
        case fill
        case id
        case fillRule = "fill-rule"
        case points
    }

    public var fill: String = ""
    public var id: String = ""
    public var fillRule: String = ""
    public var points: String = ""

    public init(attributes: [String: String], children: [Node], name: String, parent: Node?) {
        self.attributes = attributes
        self.children = children
        self.name = name
        self.parent = parent

        if let fill = attributes[Attributes.fill.rawValue] {
            self.fill = fill
        }

        if let id = attributes[Attributes.id.rawValue] {
            self.id = id
        }

        if let fillRule = attributes[Attributes.fillRule.rawValue] {
            self.fillRule = fillRule
        }

        if let points = attributes[Attributes.points.rawValue] {
            self.points = points
        }
    }
}
