//
//  TotalAmountView.swift
//  Suma
//
//  Created by Pavel Pavel on 24/09/2025.
//
import UIKit

final class TotalAmountView: UIView {
    private let textLabel = UILabel()
    private let amountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        textLabel.text = "Total amount"
        textLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        textLabel.font = UIFont(name: "Geist-Regular", size: 18)
        
        amountLabel.text = "error"
        amountLabel.textColor = UIColor(red: 0.957, green: 0.965, blue: 0.961, alpha: 1)
        amountLabel.font = UIFont(name: "Geist-Medium", size: 36)
        
        [textLabel, amountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            amountLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 14),
            amountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func render(_ amount: Double, _ currency: String) {
        self.amountLabel.text = "\(String(format: "%.f", amount)) \(currency)"
    }
}
