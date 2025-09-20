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
    private let flag = UIImageView()
    
    var currency: String
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = reuseIdentifier, currency: String) {
        self.currency = currency
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 0.949, green: 0.957, blue: 0.953, alpha: 1)
        selectionStyle = .gray
        
        title.text = currency
        title.textColor = .black
        title.font = UIFont(name: "Geist-Regular", size: 12)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        flag.image = UIImage(named: "\(currency.lowercased())FlagIcon")
        flag.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(flag)
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            
            flag.centerYAnchor.constraint(equalTo: centerYAnchor),
            flag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            flag.heightAnchor.constraint(equalToConstant: 16),
            flag.widthAnchor.constraint(equalToConstant: 16),
            
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: flag.trailingAnchor, constant: 10),
        ])
        
    }
}
