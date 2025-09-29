//
//  TransactionFormSection.swift
//  Suma
//
//  Created by Pavel Pavel on 26/09/2025.
//
import UIKit

final class TransactionFormSectionView: UIView {
    
    private let locationField = CustomPlaceholder(frame: .zero, titleText: "Location", textfieldPlaceholder: "Enter location name here", contentType: .text)
    private let paymentSection = PaymentSectionView()
    private let currencySection = CurrencySection()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        wireCallbacks()
    }
    
    var onPaymentMethodChanged: ((String) -> Void)?
    var onLocationChanged: ((String) -> Void)?
    var onCurrencyChanged: ((String) -> Void)?
    
    required init?(coder: NSCoder) { fatalError()}
    
    private func setupUI() {
        addSubview(locationField)
        addSubview(paymentSection)
        addSubview(currencySection)
        
        [locationField, paymentSection, currencySection].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            locationField.topAnchor.constraint(equalTo: topAnchor),
            locationField.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            paymentSection.topAnchor.constraint(equalTo: locationField.bottomAnchor, constant: 20),
            paymentSection.leadingAnchor.constraint(equalTo: leadingAnchor),
            paymentSection.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            currencySection.topAnchor.constraint(equalTo: paymentSection.bottomAnchor, constant: 10),
            currencySection.leadingAnchor.constraint(equalTo: leadingAnchor),
            currencySection.trailingAnchor.constraint(equalTo: trailingAnchor),
            currencySection.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func wireCallbacks() {
        locationField.onTextChanged = { [weak self] text in
            self?.onLocationChanged?(text)
        }
        
        paymentSection.onMethodChanged = { [weak self] method in
            self?.onPaymentMethodChanged?(method)
        }
        
        currencySection.onCurrencyChanged = { [weak self] currency in
            self?.onCurrencyChanged?(currency)
        }
    }
}
