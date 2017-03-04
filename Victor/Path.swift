//
//  Path.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

final public class Path: Node {
    public var attributes: [String : String]
    public var name: String
    public var children: [Node]
    public var parent: Node?

    public enum Attributes: String {
        case data = "d"
        case fill
        case id
        case fillRule = "fill-rule"
        case stroke
    }

    public var data: String = ""
    public var fill: String = ""
    public var id: String = ""
    public var fillRule: String = ""
    public var stroke: String = ""

    public init(attributes: [String: String], children: [Node], name: String, parent: Node?) {
        self.attributes = attributes
        self.children = children
        self.name = name
        self.parent = parent

        if let data = attributes[Attributes.data.rawValue] {
            self.data = data
        }

        if let fill = attributes[Attributes.fill.rawValue] {
            self.fill = fill
        }

        if let id = attributes[Attributes.id.rawValue] {
            self.id = id
        }

        if let fillRule = attributes[Attributes.fillRule.rawValue] {
            self.fillRule = fillRule
        }

        if let stroke = attributes[Attributes.stroke.rawValue] {
            self.stroke = stroke
        }
    }
}
