//
//  GraphicView.swift
//  Suma
//
//  Created by Pavel Pavel on 10/09/2025.
//
import UIKit

final class GraphicView: UIView {
    var values: [CGFloat] = [] { didSet { setNeedsLayout() } }
    var tension: CGFloat = 1 { didSet { setNeedsLayout() } }

    private let fillGradient = CAGradientLayer()
    private let fillMask = CAShapeLayer()
    private let lineLayer = CAShapeLayer()
    private let maxLineLayer = CAShapeLayer()
    private let maxLineGradient = CAGradientLayer()
    private let dotLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        lineLayer.strokeColor = UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 1).cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.lineWidth = 2
        lineLayer.lineJoin = .round
        lineLayer.lineCap = .round
        
        maxLineLayer.fillColor = nil
        maxLineLayer.strokeColor = UIColor.black.cgColor
        maxLineLayer.lineWidth = 2
        maxLineLayer.lineJoin = .round
        maxLineLayer.lineCap = .round

        maxLineGradient.colors = [
            UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 1).cgColor,
            UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 0.50).cgColor,
            UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 0.00).cgColor
        ]
        maxLineGradient.locations = [0, 0.35, 1]
        maxLineGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        maxLineGradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        maxLineGradient.mask = maxLineLayer
        
        fillGradient.colors    = [
            UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 0.35).cgColor,
            UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 0.10).cgColor,
            UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 0.00).cgColor
        ]
        fillGradient.locations = [0, 0.75, 1]
        fillGradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        fillGradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        fillGradient.mask = fillMask
        fillMask.fillColor = UIColor.black.cgColor
        fillMask.strokeColor = nil
        
        dotLayer.fillColor = UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 1).cgColor
        dotLayer.strokeColor = UIColor(red: 0.192, green: 0.204, blue: 0.196, alpha: 1).cgColor
        dotLayer.lineWidth = 3

        layer.addSublayer(fillGradient)
        layer.addSublayer(lineLayer)
        layer.addSublayer(maxLineGradient)
        layer.addSublayer(dotLayer)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard values.count >= 2 else {
            lineLayer.path = nil
            fillMask.path  = nil
            return
        }

        let rect = bounds
        let stepX = rect.width / CGFloat(values.count - 1)

        var pts: [CGPoint] = []
        pts.reserveCapacity(values.count)
        for (i, v) in values.enumerated() {
            let x = rect.minX + CGFloat(i) * stepX
            let y = rect.maxY - v * rect.height
            pts.append(CGPoint(x: x, y: y))
        }

        let curvePath = smoothedPath(through: pts, tension: tension)
        lineLayer.frame = rect
        lineLayer.path  = curvePath.cgPath
        
        maxLineGradient.frame = rect
        maxLineLayer.frame = rect
        
        let perpendPath = perpendicularPath()
        maxLineLayer.frame = rect
        maxLineLayer.path = perpendPath.cgPath
        
        let underPath = UIBezierPath()
        underPath.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        underPath.addLine(to: pts[0])
        for i in 0 ..< pts.count - 1 {
            let p0 = i == 0 ? pts[0] : pts[i - 1]
            let p1 = pts[i]
            let p2 = pts[i + 1]
            let p3 = (i + 2 < pts.count) ? pts[i + 2] : pts[i + 1]

            let d1 = CGPoint(x: (p2.x - p0.x) / 6.0 * tension, y: (p2.y - p0.y) / 6.0 * tension)
            let d2 = CGPoint(x: (p3.x - p1.x) / 6.0 * tension, y: (p3.y - p1.y) / 6.0 * tension)

            let cp1 = CGPoint(x: p1.x + d1.x, y: p1.y + d1.y)
            let cp2 = CGPoint(x: p2.x - d2.x, y: p2.y - d2.y)
            underPath.addCurve(to: p2, controlPoint1: cp1, controlPoint2: cp2)
        }
        underPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        underPath.close()

        fillGradient.frame = rect
        fillMask.frame = rect
        fillMask.path = underPath.cgPath
    }


    private func smoothedPath(through points: [CGPoint], tension: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: points[0])

        for i in 0 ..< points.count - 1 {
            let p0 = i == 0 ? points[0] : points[i - 1]
            let p1 = points[i]
            let p2 = points[i + 1]
            let p3 = (i + 2 < points.count) ? points[i + 2] : points[i + 1]

            let d1 = CGPoint(x: (p2.x - p0.x) / 6.0 * tension, y: (p2.y - p0.y) / 6.0 * tension)
            let d2 = CGPoint(x: (p3.x - p1.x) / 6.0 * tension, y: (p3.y - p1.y) / 6.0 * tension)

            let cp1 = CGPoint(x: p1.x + d1.x, y: p1.y + d1.y)
            let cp2 = CGPoint(x: p2.x - d2.x, y: p2.y - d2.y)
            path.addCurve(to: p2, controlPoint1: cp1, controlPoint2: cp2)
        }
        return path
    }
    
    private func perpendicularPath() -> UIBezierPath {
        let path = UIBezierPath()
        guard let maxIdx = values.indices.max(by: { values[$0] < values[$1] }) else { return path }
        
        let stepX = bounds.width / CGFloat(values.count - 1)
        let maxX = bounds.minX + CGFloat(maxIdx) * stepX
        let maxY = bounds.maxY - values[maxIdx] * bounds.height
        
        let dotRect = CGRect(x: maxX-4, y: maxY-4, width: 2*4, height: 2*4)
        dotLayer.frame = bounds
        dotLayer.path = UIBezierPath(ovalIn: dotRect).cgPath
        
        print("step: \(stepX)")
        print("maxX: \(maxX)")
        print("maxY: \(maxY)")
        
        path.move(to: CGPoint(x: maxX, y: maxY))
        path.addLine(to: CGPoint(x: maxX, y: bounds.maxY))
        return path
    }
}
