//
//  Node.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

public protocol Node {
    var name: String { get set }
    var attributes: [String: String] { get set }
    var children: [Node] { get set }
    var parent: Node? { get set }
}

public enum NodeType: String {
    case svg
    case rect
}
