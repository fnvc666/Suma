//
//  CurrencySection.swift
//  Suma
//
//  Created by Pavel Pavel on 17/09/2025.
//
import UIKit

final class CurrencySection: UIView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        label.text = "Currency"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        label.font = UIFont(name: "Geist-Regular", size: 16)
        
    }
}
