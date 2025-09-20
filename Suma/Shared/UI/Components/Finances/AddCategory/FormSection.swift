//
//  Untitled.swift
//  Suma
//
//  Created by Pavel Pavel on 17/09/2025.
//
import UIKit

final class FormSection: UIView {
    
    var onNameChanged: ((String) -> Void)?
    var onAmountChanged: ((String) -> Void)?
    var onCurrencyChanged: ((String) -> Void)?
    
    let customNameField = CustomPlaceholder(frame: .zero, titleText: "Name", textfieldPlaceholder: "Enter category name", contentType: .text)
    let customAmountField = CustomPlaceholder(frame: .zero, titleText: "Total Amount", textfieldPlaceholder: "Enter amount", contentType: .num)
    let currencySection = CurrencySection()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        wireCallbacks()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        addSubview(customNameField)
        addSubview(customAmountField)
        addSubview(currencySection)
        customNameField.translatesAutoresizingMaskIntoConstraints = false
        customAmountField.translatesAutoresizingMaskIntoConstraints = false
        currencySection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customNameField.topAnchor.constraint(equalTo: topAnchor),
            customNameField.leadingAnchor.constraint(equalTo: leadingAnchor),
            customNameField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            customAmountField.topAnchor.constraint(equalTo: customNameField.bottomAnchor, constant: 20),
            customAmountField.leadingAnchor.constraint(equalTo: customNameField.leadingAnchor),
            customAmountField.trailingAnchor.constraint(equalTo: customNameField.trailingAnchor),
            
            currencySection.topAnchor.constraint(equalTo: customAmountField.bottomAnchor, constant: 20),
            currencySection.leadingAnchor.constraint(equalTo: customAmountField.leadingAnchor),
            currencySection.trailingAnchor.constraint(equalTo: customAmountField.trailingAnchor),
            
            currencySection.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func wireCallbacks() {
        customNameField.onTextChanged = { [weak self] text in
            self?.onNameChanged?(text)
        }
        
        customAmountField.onTextChanged = { [weak self] text in
            self?.onAmountChanged?(text)
        }
        
        currencySection.onCurrencyChanged = { [weak self] currency in
            self?.onCurrencyChanged?(currency)
        }
    }
    
}
