//
//  Rect.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

public struct Rect: Node {
    public var name: String
    public var attributes: [String : String]
    public var children: [Node]
    public var parent: Node?

    public var width: String
    public var height: String
    public var x: String
    public var y: String

    public init(attributes: [String: String], children: [Node], name: String, parent: Node?) {
        self.attributes = attributes
        self.children = children
        self.name = name
        self.parent = parent

        if let width = attributes["width"] {
            self.width = width
        } else {
            self.width = ""
        }

        if let height = attributes["height"] {
            self.height = height
        } else {
            self.height = ""
        }

        if let x = attributes["x"] {
            self.x = x
        } else {
            self.x = ""
        }

        if let y = attributes["y"] {
            self.y = y
        } else {
            self.y = ""
        }
    }
}
