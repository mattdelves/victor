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
}
