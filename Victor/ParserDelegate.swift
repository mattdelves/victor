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

        switch type {
        case .svg:
            rootNode = SVG(attributes: attributeDict, children: [], name: elementName, parent: nil)
        case .rect:
            if currentNode == nil {
                let rect = Rect(name: elementName, attributes: attributeDict, children: [], parent: rootNode)
                rootNode?.children.append(rect)
                currentNode = rect
            }
        }
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // end
        currentNode = nil
    }
}
