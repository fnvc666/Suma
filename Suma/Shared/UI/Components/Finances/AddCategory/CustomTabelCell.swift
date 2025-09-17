//
//  CustomTabelCell.swift
//  Suma
//
//  Created by Pavel Pavel on 17/09/2025.
//
import UIKit

final class CustomTabelCell: UITableViewCell {
    static let reuseIdentifier = "CustomTabelCell"
    private let title = UILabel()
    
    var currency: String
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = reuseIdentifier, currency: String) {
        self.currency = currency
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        selectionStyle = .none
        
        title.text = currency
        title.textColor = .white
        title.font = .systemFont(ofSize: 17, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
}
