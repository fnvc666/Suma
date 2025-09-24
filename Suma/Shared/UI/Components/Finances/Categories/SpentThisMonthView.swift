//
//  SpentThisMonthView.swift
//  Suma
//
//  Created by Pavel Pavel on 24/09/2025.
//
import UIKit

final class SpentThisMonthView: UIView {
    private let headLabel = UILabel()
    private let footerHstack = UIStackView()
    private let spentLabel = UILabel()
    private let spacer = UIView()
    private let leftLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError()}
    
    private func setupUI() {
        headLabel.text = "Spent this month"
        headLabel.textColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1)
        headLabel.font = UIFont(name: "Geist-Medium", size: 18)
        
        footerHstack.axis = .horizontal
        footerHstack.alignment = .center
        
        spentLabel.text = "588 USD spent"
        spentLabel.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.5)
        spentLabel.font = UIFont(name: "Geist-Regular", size: 12)
        
        leftLabel.text = "256 USD left"
        leftLabel.textColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1)
        leftLabel.font = UIFont(name: "Geist-Regular", size: 12)
        
        [spentLabel, spacer, leftLabel].forEach { footerHstack.addArrangedSubview($0) }
        
        [headLabel, footerHstack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: topAnchor),
            headLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            footerHstack.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 10),
            footerHstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerHstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerHstack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spentLabel.leadingAnchor.constraint(equalTo: footerHstack.leadingAnchor),
            leftLabel.trailingAnchor.constraint(equalTo: footerHstack.trailingAnchor),
        ])
    }
}
