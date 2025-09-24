//
//  SpentIndicatorView.swift
//  Suma
//
//  Created by Pavel Pavel on 24/09/2025.
//
import UIKit

final class SpentIndicatorView: UIView {
    
    private let emptyLayer = CAShapeLayer()
    private let gradientContainer = CALayer()
    private let gradientLayer = CALayer()
    private let filledMask = CAShapeLayer()
    
    var totalSegments: Int = 30
    var spacing: CGFloat = 3
    var cornerRadius: CGFloat = 6
    var emptyColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
    var progress: CGFloat = 0 { didSet { progress = max(0, min(1, progress)); updateMask() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        setupLayer()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    func setupLayer() {
        layer.addSublayer(emptyLayer)
        
        gradientContainer.addSublayer(gradientLayer)
        gradientContainer.mask = filledMask
        layer.addSublayer(gradientContainer)
        
        emptyLayer.fillColor = emptyColor.cgColor
        emptyLayer.allowsEdgeAntialiasing = true
        filledMask.allowsEdgeAntialiasing = true
    }
    
    func setGradientImage(_ image: UIImage) {
        gradientLayer.contents = image.cgImage
        gradientLayer.contentsGravity = .resizeAspectFill
        setNeedsLayout()
    }
    
    func setProgress(_ value: CGFloat) {
        progress = max(0, min(1, value))
        updateMask()
    }
    
    // MARK: – Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        emptyLayer.frame = bounds
        gradientContainer.frame = bounds
        gradientLayer.frame = bounds
        filledMask.frame = bounds
        
        emptyLayer.path = allSegmentsPath().cgPath
        updateMask()
    }
    
    // MARK: – Построение путей
    private func allSegmentsPath() -> UIBezierPath {
        let n = max(1, totalSegments)
        let w = (bounds.width - spacing * CGFloat(n - 1)) / CGFloat(n)
        let h = bounds.height
        let path = UIBezierPath()
        for i in 0..<n {
            let x = CGFloat(i) * (w + spacing)
            path.append(UIBezierPath(roundedRect: CGRect(x: x, y: 0, width: w, height: h),
                                     cornerRadius: cornerRadius))
        }
        return path
    }
    
    private func filledSegmentsPath(for progress: CGFloat) -> UIBezierPath {
        let n = max(1, totalSegments)
        let w = (bounds.width - spacing * CGFloat(n - 1)) / CGFloat(n)
        let h = bounds.height
        
        let clamped = max(0, min(1, progress))
        let filled = clamped * CGFloat(n)
        let full = Int(floor(filled)) 
        
        let path = UIBezierPath()
        
        // Полные сегменты
        for i in 0..<full {
            let x = CGFloat(i) * (w + spacing)
            path.append(UIBezierPath(roundedRect: CGRect(x: x, y: 0, width: w, height: h),
                                     cornerRadius: cornerRadius))
        }
        
        return path
    }
    
    private func updateMask() {
        let newPath = filledSegmentsPath(for: progress).cgPath
        filledMask.path = newPath
        filledMask.fillColor = UIColor.white.cgColor
    }
}
