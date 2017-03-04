//
//  Renderer.swift
//  Victor
//
//  Created by Seán Labastille on 04.03.17.
//  Copyright © 2017 Matthew Delves. All rights reserved.
//

import Foundation

extension SVG {
    var pageSize: CGRect? {
        let (width, height) = (self.width.pointsValue, self.height.pointsValue)
        var pageSize = CGRect.zero
        if let width = width, let height = height {
            pageSize = CGRect(x: 0, y: 0, width: width, height: width)
            return pageSize
        }
        return nil
    }
}

extension String {
    var doubleValue: Double? {
        get {
            return NumberFormatter().number(from: self)?.doubleValue
        }
    }

    var pointsValue: Double? {
        if self.hasSuffix("cm") {
            if let magnitude = self.substring(to: self.index(self.endIndex, offsetBy: -2)).doubleValue {
            let points = (magnitude / 2.54) * 72
            return points
            } else {
                return nil
            }
        }
        if self.hasSuffix("px") {
            let magnitude = self.substring(to: self.index(self.endIndex, offsetBy: -2))
            return Double(magnitude.doubleValue ?? 0) * Double(UIScreen.main.scale)
        }
        return nil
    }

    var colorValue: UIColor? {
        switch self {
        case "red":
            return .red
        case "purple":
            return .purple
        case "none":
            return .clear
        case "blue":
            return .blue
        case "green":
            return .green
        default:
            return nil
        }
    }

    var affineTransformValue: CGAffineTransform {
        get {
            let transforms = try! NSRegularExpression(pattern: "(\\w+)\\((.*?)\\)", options: [])
            let matches = transforms.matches(in: self, options: [], range: NSMakeRange(0, self.lengthOfBytes(using: .utf8)))

            var affineTransform = CGAffineTransform.identity
            matches.forEach { (match) in
                if match.numberOfRanges != 3 { return }
                let name = (self as NSString).substring(with: match.rangeAt(1))
                let arguments = (self as NSString).substring(with: match.rangeAt(2)).components(separatedBy: " ")
                switch name {
                case "translate":
                    if arguments.count != 2 { return }
                    affineTransform = affineTransform.translatedBy(x: CGFloat(arguments[0].doubleValue ?? 0), y: CGFloat(arguments[1].doubleValue ?? 0))
                case "rotate":
                    if arguments.count != 1 { return }
                    affineTransform  = affineTransform.rotated(by: CGFloat(((arguments[0].doubleValue ?? 0)/360) * Double.pi))
                default:
                    fatalError("Unexpected transform type")
                }

            }
            return affineTransform
        }
    }
}

public final class Renderer {
    private var context: CGContext? = nil
    public init() {}
    /// Renders the given SVG into a PDF
    ///
    /// - Parameter svg: SVG fragment to render
    /// - Returns: PDF data
    public func render(_ svg: SVG) -> Data {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, svg.pageSize ?? .zero, nil)
        context = UIGraphicsGetCurrentContext()
        render(element: svg)
        UIGraphicsEndPDFContext()
        return pdfData as Data
    }

    private func render(element: SVG) {
        UIGraphicsBeginPDFPageWithInfo(element.pageSize ?? .zero, nil)
        element.children.forEach({render(element: $0)})
    }

    private func render(element: Rect) {
        let (x,y, width, height, strokeWidth) = (element.x.doubleValue ?? 0, element.y.doubleValue ?? 0, element.width.doubleValue ?? 0, element.height.doubleValue ?? 0, element.strokeWidth.doubleValue ?? 0)
        (element.stroke.colorValue ?? .clear).setStroke()
        (element.fill.colorValue ?? .clear).setFill()
        // TODO: Set line width
        let path = UIBezierPath(rect: CGRect(x: x, y: y, width: width, height: height))
        path.stroke()
        path.fill()
    }

    private func render(element: Node) {
        if let rect = element as? Rect { render(element: rect) }
        else if let group = element as? Group { render(element: group) } else {
            element.children.forEach({render(element: $0)})
        }
    }

    private func render(element: Group) {
        let transform = element.transform.affineTransformValue
        context?.concatenate(transform)
        element.children.forEach({render(element: $0)})
        context?.concatenate(.identity)
    }
}
