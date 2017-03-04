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

    var pointValue: CGPoint? {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.uppercaseLetters)
            let components = trimmed.components(separatedBy: ",")
            return CGPoint(x: components.first?.doubleValue ?? 0, y: components[1].doubleValue ?? 0)
        }
    }

    var bezierPathValue: UIBezierPath {
        get {
            var path = UIBezierPath()
            var commands = components(separatedBy: " ")
            repeat {
                if let index = commands.first?.startIndex {
                switch commands.first?[index] ?? Character("") {
                case Character("M"):
                    let move = commands.removeFirst()
                    path.move(to: move.pointValue!)
                case Character("L"):
                    let line = commands.removeFirst()
                    path.addLine(to: line.pointValue!)
                case Character("C"):
                    let curve = commands[0...2]
                    let points = curve.flatMap({$0.pointValue})
                    path.addCurve(to: points[2], controlPoint1: points[0], controlPoint2: points[1])
                    commands.removeFirst(3)
                default:
                    _ = commands.removeFirst()
                    }
                }
            } while (commands.count > 0)
            return path
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
            if hasPrefix("#"), characters.count == 7 {
                let rgb = self[self.index(startIndex, offsetBy: 1)...self.index(startIndex, offsetBy: 6)]
                var rgbValue: UInt32 = 0
                Scanner(string: rgb).scanHexInt32(&rgbValue)

                return UIColor(
                    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                    alpha: CGFloat(1.0)
                )
            }
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
        if let rect = element as? Rect {
            render(element: rect)
        } else if let group = element as? Group {
            render(element: group)
        } else if let path = element as? Path {
            render(element: path)
        } else if let polygon = element as? Polygon {
            render(element: polygon)
        } else {
            element.children.forEach({render(element: $0)})
        }
    }

    private func render(element: Group) {
        let transform = element.transform.affineTransformValue
        let current = context?.ctm ?? .identity
        context?.concatenate(transform)
        element.children.forEach({render(element: $0)})
        context?.concatenate(current)
    }

    private func render(element: Polygon) {
        var points = element.points.components(separatedBy: " ")
        let path = UIBezierPath()
        path.move(to: .zero)
        repeat {
            let point = CGPoint(x: CGFloat(points[0].doubleValue ?? 0), y: CGFloat(points[1].doubleValue ?? 0))
            path.addLine(to: point)
            points.removeFirst(2)
        } while !points.isEmpty
        (element.fill.colorValue ?? .clear).setFill()
        path.usesEvenOddFillRule = (element.fillRule == "evenodde" ? true : false)
        path.fill()
    }

    private func render(element: Path) {
        let data = element.data
        let path = data.bezierPathValue
        (element.stroke.colorValue ?? .clear).setStroke()
        (element.fill.colorValue ?? .clear).setFill()
        context?.setLineWidth(CGFloat(element.strokeWidth.doubleValue ?? 1))
        path.stroke()
        path.fill()
        path.usesEvenOddFillRule = (element.fillRule == "evenodde" ? true : false)
    }
}
