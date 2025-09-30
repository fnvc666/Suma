//
//  TransactionAmountView.swift
//  Suma
//
//  Created by Pavel Pavel on 26/09/2025.
//
import UIKit

final class TransactionAmountView: UIView {
    private let amountLabel = UILabel()
    private let amountTextField = UITextField()
    private var amount: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    var onAmountChanged: ((Double?) -> Void)?
    
    required init?(coder: NSCoder) {fatalError()}
    
    private func setupUI() {
        amountLabel.text = "Amount"
        amountLabel.textColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 0.7)
        amountLabel.font = UIFont(name: "Geist-Regular", size: 18)
        
        amountTextField.keyboardType = .decimalPad
        amountTextField.placeholder = "Enter amount"
        amountTextField.textColor = .white
        amountTextField.textAlignment = .center
        amountTextField.font = UIFont(name: "Geist-Medium", size: 36)
        amountTextField.tintColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.5)
        amountTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        [amountLabel, amountTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: topAnchor),
            amountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 14),
            amountTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc private func editingChanged() {
        let raw = amountTextField.text?.replacingOccurrences(of: ",", with: ".") ?? ""
        onAmountChanged?(Double(raw))
    }
}

