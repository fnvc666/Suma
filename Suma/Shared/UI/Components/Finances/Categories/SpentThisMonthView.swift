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
    private let spentIndicator = SpentIndicatorView()
    
    private var spent: Double = 0
    private var left: Double = 0
    
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
        
        spentLabel.text = "\(spent) USD spent"
        spentLabel.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.5)
        spentLabel.font = UIFont(name: "Geist-Regular", size: 12)
        
        leftLabel.text = "\(left) USD left"
        leftLabel.textColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1)
        leftLabel.font = UIFont(name: "Geist-Regular", size: 12)
        
        [spentLabel, spacer, leftLabel].forEach { footerHstack.addArrangedSubview($0) }
        
        [headLabel, spentIndicator, footerHstack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: topAnchor),
            headLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            spentIndicator.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 10),
            spentIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            spentIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            spentIndicator.heightAnchor.constraint(equalToConstant: 45),
            
            footerHstack.topAnchor.constraint(equalTo: spentIndicator.bottomAnchor, constant: 10),
            footerHstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerHstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerHstack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spentLabel.leadingAnchor.constraint(equalTo: footerHstack.leadingAnchor),
            leftLabel.trailingAnchor.constraint(equalTo: footerHstack.trailingAnchor),
        ])
    }
    
    func render(_ current: Double, _ budget: Double, _ currency: String, _ gradient: String) {
        self.spent = current
        self.left = budget - current
        
        spentLabel.text = "\(String(format: "%.f", spent)) \(currency) spent"
        leftLabel.text = "\(String(format: "%.f", left)) \(currency) left"
        spentIndicator.setProgress(spent / budget)
        // MARK: TODO
        /// discus with designer
        //        spentIndicator.setGradientImage(UIImage(named: gradient)!)
    }
}
