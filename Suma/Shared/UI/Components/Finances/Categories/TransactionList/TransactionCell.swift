//
//  TransactionCell.swift
//  Suma
//
//  Created by Pavel Pavel on 30/09/2025.
//
import UIKit

final class TransactionCell: UICollectionViewCell {
    static let reuseID = "TransactionCell"
    
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    private let imageContainer = UIView()
    private let paymentImage = UIImageView()
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func configure() {
        contentView.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        layer.cornerRadius = 16
        
        imageContainer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        imageContainer.layer.cornerRadius = 24
        
        paymentImage.tintColor = .black
        paymentImage.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont(name: "Geist-Regular", size: 16)
        titleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        amountLabel.font = UIFont(name: "Geist-Medium", size: 20)
        amountLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        amountLabel.textAlignment = .right
        
        dateLabel.font = UIFont(name: "Geist-Regular", size: 12)
        dateLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        
        [imageContainer, paymentImage, titleLabel, dateLabel, amountLabel, amountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageContainer.heightAnchor.constraint(equalToConstant: 48),
            imageContainer.widthAnchor.constraint(equalToConstant: 48),
            imageContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            paymentImage.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            paymentImage.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            paymentImage.heightAnchor.constraint(equalToConstant: 28),
            paymentImage.widthAnchor.constraint(equalToConstant: 28),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 16),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 16),
            
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 92)
        ])
    }
    
    func configure(with transaction: Transaction) {
        titleLabel.text = transaction.location
        amountLabel.text = "- \(transaction.amount) \(transaction.currency)"
        paymentImage.image = UIImage(systemName: transaction.paymentMethod == "Cash" ? "dollarsign" : "creditcard")
        let formatted = DateFormatter()
        formatted.dateFormat = "MMM dd"
        dateLabel.text = formatted.string(from: transaction.date)
    }
}
