//
//  GradientBackgroundView.swift
//  Suma
//
//  Created by Pavel Pavel on 02/09/2025.
//
import UIKit

final class GradientBackgroundView: UIView {
    enum Style { case screen, card }
    private let glow = CAGradientLayer()
    private let style: Style

    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.10, alpha: 1)

        glow.type = .radial

        let greenStrong = UIColor(red: 0.30, green: 0.41, blue: 0.26, alpha: 1)
        let greenSoft   = UIColor(red: 0.20, green: 0.26, blue: 0.18, alpha: 1)

        glow.colors = [
            greenStrong.withAlphaComponent(0.85).cgColor,
            greenSoft  .withAlphaComponent(0.55).cgColor,
            UIColor.clear.cgColor
        ]
        glow.locations = [0.0, 0.35, 1.0] as [NSNumber]

        glow.startPoint = CGPoint(x: 0.5, y: 0.3)
        glow.endPoint = CGPoint(x: 1.9, y: 0.7)

        layer.insertSublayer(glow, at: 0)

        if case .card = style {
            layer.cornerRadius = 16
            layer.masksToBounds = true
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSubviews() {
        super.layoutSubviews()
        glow.frame = bounds
        
        if case .screen = style {
//            let scale: CGFloat = 2.0
//            glow.bounds = CGRect(x: 0, y: 0,
//                               width: bounds.width * scale,
//                               height: bounds.height * scale)
//            glow.position = CGPoint(x: bounds.midX, y: bounds.midY - bounds.height * 0.2)
        }
    }
}
