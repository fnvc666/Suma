//
//  PaymentSection.swift
//  Suma
//
//  Created by Pavel Pavel on 28/09/2025.
//
import UIKit

final class PaymentSectionView: UIView {
    private let label = UILabel()
    private let picker = PaymentPickerView()
    
    var onMethodChanged: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        picker.onMethodSelected = { [weak self] method in
            self?.onMethodChanged?(method)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        addSubview(label)
        addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Payment method"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        label.font = UIFont(name: "Geist-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            picker.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            picker.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setCurrency(_ code: String) {
            picker.setCurrency(code)
        }
}
