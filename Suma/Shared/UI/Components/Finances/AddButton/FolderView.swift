//
//  FolderView.swift
//  Suma
//
//  Created by Pavel Pavel on 12/09/2025.
//
import UIKit

final class FolderView: UIView {
    private let folderColor = UIImageView(image: UIImage(named: "BlueGradient"))
    private let subtract = UIImageView(image: UIImage(named: "Subtract"))
    private let categoryLabel = UILabel()
    private let amountLabel = UILabel()
    private let number = UILabel()
    
    var category: Column
    
    init(frame: CGRect, category: Column) {
        self.category = category
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.21, alpha: 1).cgColor
        layer.cornerRadius = 21
        
        folderColor.contentMode = .scaleAspectFit
        folderColor.layer.cornerRadius = 16
        folderColor.clipsToBounds = true
        folderColor.translatesAutoresizingMaskIntoConstraints = false
        
        subtract.contentMode = .scaleAspectFit
        subtract.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.text = category.category
        categoryLabel.font = UIFont(name: "Geist-Regular", size: 14)
        categoryLabel.textColor = .white
        
        amountLabel.text = String(format: "%0.f$", category.amount)
        amountLabel.font = UIFont(name: "Geist-Regular", size: 12)
        amountLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        
        number.text = "01"
        number.font = UIFont(name: "Geist-Regular", size: 28)
        number.textColor = .white
        
        addSubview(folderColor)
        addSubview(subtract)
        
        subtract.addSubview(categoryLabel)
        subtract.addSubview(number)
        subtract.addSubview(amountLabel)
        
        [categoryLabel, number, amountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 166),
            widthAnchor.constraint(equalToConstant: 166),
            
            folderColor.centerYAnchor.constraint(equalTo: centerYAnchor),
            folderColor.centerXAnchor.constraint(equalTo: centerXAnchor),
            folderColor.widthAnchor.constraint(equalToConstant: 156),
            folderColor.heightAnchor.constraint(equalToConstant: 156),
            
            subtract.leadingAnchor.constraint(equalTo: folderColor.leadingAnchor),
            subtract.trailingAnchor.constraint(equalTo: folderColor.trailingAnchor),
            subtract.bottomAnchor.constraint(equalTo: folderColor.bottomAnchor),
            
            subtract.heightAnchor.constraint(equalToConstant: 114),
            
            categoryLabel.topAnchor.constraint(equalTo: subtract.topAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: subtract.leadingAnchor, constant: 9),
            
            number.bottomAnchor.constraint(equalTo: subtract.bottomAnchor, constant: -7),
            number.leadingAnchor.constraint(equalTo: subtract.leadingAnchor, constant: 9),
            
            amountLabel.bottomAnchor.constraint(equalTo: subtract.bottomAnchor, constant: -7),
            amountLabel.trailingAnchor.constraint(equalTo: subtract.trailingAnchor, constant: -9),
        ])
    }
}
