//
//  ParserDelegate.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

final public class ParserDelegate: NSObject, XMLParserDelegate {
    var rootNode: Node?
    var currentNode: Node?

    public func parserDidStartDocument(_ parser: XMLParser) {
        //
        print("Starting the document")
    }

    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        // do stuff
        print("An error occurred - \(parseError.localizedDescription)")
    }

    public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        // do stuff
    }

    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        guard let type = NodeType(rawValue: elementName) else { return }

        var parent: Node? = currentNode ?? rootNode
        var newNode: Node?

        switch type {
        case .svg:
            rootNode = SVG(attributes: attributeDict, children: [], name: elementName, parent: nil)
        case .group:
            newNode = Group(attributes: attributeDict, children: [], name: elementName, parent: parent)
        case .rect:
            newNode = Rect(attributes: attributeDict, children: [], name: elementName, parent: parent)
        case .path:
            newNode = Path(attributes: attributeDict, children: [], name: elementName, parent: parent)
        case .polygon:
            newNode = Polygon(attributes: attributeDict, children: [], name: elementName, parent: parent)
        case .mask:
            newNode = Mask(attributes: attributeDict, children: [], name: elementName, parent: parent)
        case .defs:
            newNode = Defs(attributes: attributeDict, children: [], name: elementName, parent: parent)
        }

        if let node = newNode {
            parent?.children.append(node)
            print("Number of children is now: \(parent?.children.count)")
            currentNode = node
        }
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentNode = currentNode?.parent
    }
}
