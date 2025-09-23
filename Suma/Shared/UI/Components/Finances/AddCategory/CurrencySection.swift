//
//  CurrencySection.swift
//  Suma
//
//  Created by Pavel Pavel on 17/09/2025.
//
import UIKit

final class CurrencySection: UIView {
    private let label = UILabel()
    let picker = CurrencyPickerView()
    
    var onCurrencyChanged: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        picker.onCurrencySelected = { [weak self] currency in
            self?.onCurrencyChanged?(currency)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        label.text = "Currency"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        label.font = UIFont(name: "Geist-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(picker)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            picker.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            picker.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setCurrency(_ code: String) {
            picker.setCurrency(code)
        }
}
