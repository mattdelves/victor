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
    public var parent: Node?

    public enum Attributes: String {
        case id
        case points
    }

    public var id: String = ""
    public var points: String = ""

    public init(attributes: [String: String], children: [Node], name: String, parent: Node?) {
        self.attributes = attributes
        self.children = children
        self.name = name
        self.parent = parent

        if let id = attributes[Attributes.id.rawValue] {
            self.id = id
        }

        if let points = attributes[Attributes.points.rawValue] {
            self.points = points
        }
    }
}
