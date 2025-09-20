//
//  AddNewCategoryButton.swift
//  Suma
//
//  Created by Pavel Pavel on 12/09/2025.
//
import UIKit

final class AddNewCategoryButton: UIButton {
    private let hstack = UIStackView()
    private let title = UILabel()
    private let icon = UIImageView(image: UIImage(systemName: "plus"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        
        hstack.axis = .horizontal
        hstack.translatesAutoresizingMaskIntoConstraints = false
        hstack.isUserInteractionEnabled = false

        title.text = "Add category"
        title.font = UIFont(name: "Geist-Medium", size: 14)
        title.textColor = .white
        
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        hstack.addArrangedSubview(title)
        hstack.addArrangedSubview(icon)
        
        widthAnchor.constraint(equalToConstant: 170).isActive = true
        heightAnchor.constraint(equalToConstant: 36).isActive = true
        addSubview(hstack)
        
        NSLayoutConstraint.activate([
            hstack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            hstack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            hstack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            hstack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
    }
}
