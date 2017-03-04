//
//  Rect.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

public class Rect: Node {
    public var name: String
    public var attributes: [String : String]
    public var children: [Node]
    public weak var parent: Node?

    public var width: String = ""
    public var height: String = ""
    public var x: String = ""
    public var y: String = ""
    public var stroke: String = ""
    public var strokeWidth: String = ""
    public var fill: String = ""

    public enum Attributes: String {
        case width
        case height
        case x
        case y
        case fill
        case stroke
        case strokeWidth = "stroke-width"
    }

    public init(attributes: [String: String], children: [Node], name: String, parent: Node?) {
        self.attributes = attributes
        self.children = children
        self.name = name
        self.parent = parent

        if let width = attributes[Attributes.width.rawValue] {
            self.width = width
        }

        if let height = attributes[Attributes.height.rawValue] {
            self.height = height
        }

        if let x = attributes[Attributes.x.rawValue] {
            self.x = x
        }

        if let y = attributes[Attributes.y.rawValue] {
            self.y = y
        }

        if let stroke = attributes[Attributes.stroke.rawValue] {
            self.stroke = stroke
        }

        if let strokeWidth = attributes[Attributes.strokeWidth.rawValue] {
            self.strokeWidth = strokeWidth
        }

        if let fill = attributes[Attributes.fill.rawValue] {
            self.fill = fill
        }
    }
}
