//
//  Parser.swift
//  Victor
//
//  Created by Matthew Delves on 4/3/17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

public final class Parser {
    var xmlDelegate: ParserDelegate
    var location: String

    init(file: String) {
        xmlDelegate = ParserDelegate()
        location = file
    }

    public func parse() -> SVG? {
        guard let url = URL(string: location), let parser = XMLParser(contentsOf: url) else { return nil }

        parser.delegate = xmlDelegate
        if parser.parse() {
            return xmlDelegate.rootNode as? SVG
        }

        return nil
    }
}
