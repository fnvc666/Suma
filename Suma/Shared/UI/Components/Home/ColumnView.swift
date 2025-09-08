//
//  ColumnView.swift
//  Suma
//
//  Created by Pavel Pavel on 08/09/2025.
//
import UIKit

struct Column {
    let category: String
    let amount: String
    let maximum: Int
    let current: Int
}

final class ColumnView: UIView {
    private let column: Column
    private let vstack = UIStackView()
    private let maxColumnLabel = UILabel()
    private let fillColumnLabel = UILabel()
    private let categoryLabel = UILabel()
    private let amountLabel = UILabel()
    
    init(frame: CGRect, column: Column) {
        self.column = column
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(vstack)
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.spacing = 5
        vstack.translatesAutoresizingMaskIntoConstraints = false
        
        maxColumnLabel.backgroundColor = UIColor(red: 0.871, green: 0.859, blue: 0.8, alpha: 0.2)
        maxColumnLabel.layer.cornerRadius = 9
        maxColumnLabel.layer.masksToBounds = true
        maxColumnLabel.heightAnchor.constraint(equalToConstant: 160).isActive = true
        maxColumnLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        fillColumnLabel.backgroundColor = UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 1)
        fillColumnLabel.layer.cornerRadius = 9
        fillColumnLabel.layer.masksToBounds = true
        let cur = CGFloat(column.current) / CGFloat(column.maximum) * 160
        fillColumnLabel.heightAnchor.constraint(equalToConstant: cur).isActive = true
        fillColumnLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        fillColumnLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.text = column.category
        categoryLabel.textColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 0.6)
        categoryLabel.font = UIFont(name: "Geist-Regular", size: 12)
        
        amountLabel.text = "\(column.amount)$"
        amountLabel.textColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1)
        amountLabel.font = UIFont(name: "Geist-Semibold", size: 12)
        
        maxColumnLabel.addSubview(fillColumnLabel)
        vstack.addArrangedSubview(maxColumnLabel)
        vstack.addArrangedSubview(categoryLabel)
        vstack.addArrangedSubview(amountLabel)
        
        vstack.setCustomSpacing(26, after: maxColumnLabel)
        
        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: topAnchor),
            vstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            fillColumnLabel.leadingAnchor.constraint(equalTo: maxColumnLabel.leadingAnchor),
            fillColumnLabel.trailingAnchor.constraint(equalTo: maxColumnLabel.trailingAnchor),
            fillColumnLabel.bottomAnchor.constraint(equalTo: maxColumnLabel.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
   
}

