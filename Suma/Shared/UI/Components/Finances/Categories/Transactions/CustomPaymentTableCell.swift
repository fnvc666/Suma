//
//  CustomPaymentTableCell.swift
//  Suma
//
//  Created by Pavel Pavel on 28/09/2025.
//
import UIKit

final class CustomPaymentTableCell: UITableViewCell {
    static let reuseIdentifier = "CustomPaymentTableCell"
    private let title = UILabel()
    private let icon = UIImageView()
    
    var method: String
    var iconName: String
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = reuseIdentifier, method: String, iconName: String) {
        self.method = method
        self.iconName = iconName
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 0.949, green: 0.957, blue: 0.953, alpha: 1)
        selectionStyle = .gray
        
        title.text = method
        title.textColor = .black
        title.font = UIFont(name: "Geist-Regular", size: 12)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        icon.image = UIImage(systemName: iconName)
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            icon.heightAnchor.constraint(equalToConstant: 16),
            icon.widthAnchor.constraint(equalToConstant: 16),
            
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
        ])
    }
}
