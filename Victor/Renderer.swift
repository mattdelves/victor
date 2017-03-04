//
//  Renderer.swift
//  Victor
//
//  Created by Seán Labastille on 04.03.17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

extension String {
    var doubleValue: Double? {
        get {
            return NumberFormatter().number(from: self)?.doubleValue
        }
    }
}

public final class Renderer {
    /// Renders the given SVG into a PDF
    ///
    /// - Parameter svg: SVG fragment to render
    /// - Returns: PDF data
    public class func render(_ svg: SVG) -> Data {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        render(element: svg)
        UIGraphicsEndPDFContext()
        return pdfData as Data
    }

    private class func render(element: SVG) {
        UIGraphicsBeginPDFPageWithInfo(.zero, nil) // TODO: Set page size based on SVG canvas size
        element.children.forEach({render(element: $0)})
    }

    private class func render(element: Rect) {
        let (x,y, width, height) = (element.x.doubleValue ?? 0, element.y.doubleValue ?? 0, element.width.doubleValue ?? 0, element.height.doubleValue ?? 0)
        UIColor.red.set()
        UIBezierPath(rect: CGRect(x: x, y: y, width: width, height: height)).stroke()
    }

    private class func render(element: Node) {
        if let rect = element as? Rect { render(element: rect) }
        element.children.forEach({render(element: $0)})
    }
}
