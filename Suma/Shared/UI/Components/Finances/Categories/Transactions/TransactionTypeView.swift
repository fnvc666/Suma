//
//  TransactionTypeView.swift
//  Suma
//
//  Created by Pavel Pavel on 26/09/2025.
//
import UIKit

final class TransactionTypeView: UIView {
    private let hstack = UIStackView()
    private let spentButton = TransactionTypeButton()
    private let receivedButton = TransactionTypeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        hstack.axis = .horizontal
        hstack.alignment = .center
        hstack.distribution = .fillEqually
        hstack.spacing = 10
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        spentButton.isSelected = true
        spentButton.configure("Spent", "arrow.down")
        spentButton.addTarget(self, action: #selector(typeSelected), for: .touchUpInside)
        
        receivedButton.isSelected = false
        receivedButton.configure("Received", "arrow.up")
        receivedButton.addTarget(self, action: #selector(typeSelected), for: .touchUpInside)
        
        [spentButton, receivedButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            hstack.addArrangedSubview($0)
        }
        
        addSubview(hstack)
        
        NSLayoutConstraint.activate([
            hstack.topAnchor.constraint(equalTo: topAnchor),
            hstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hstack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc private func typeSelected() {
        [spentButton, receivedButton].forEach {
            $0.isSelected.toggle()
            $0.configureColor()
        }
    }
}

final class TransactionTypeButton: UIButton {
    private let hstack = UIStackView()
    private let spacer = UIView()
    private let title = UILabel()
    private let icon = UIImageView()
    
    var titleText: String?
    var iconName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 8
        
        hstack.axis = .horizontal
        hstack.spacing = 10
        hstack.isUserInteractionEnabled = false
        hstack.translatesAutoresizingMaskIntoConstraints = false
        hstack.isLayoutMarginsRelativeArrangement = true
        hstack.layoutMargins = .init(top: 6, left: 12, bottom: 6, right: 12)
        
        spacer.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        title.font = UIFont(name: "Geist-Medium", size: 14)
        title.textColor = .black
        icon.tintColor = .black
        [title, spacer, icon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            hstack.addArrangedSubview($0)
        }
        
        addSubview(hstack)
        
        NSLayoutConstraint.activate([
            hstack.topAnchor.constraint(equalTo: topAnchor),
            hstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hstack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configure(_ title: String, _ icon: String) {
        self.title.text = title
        self.icon.image = UIImage(systemName: icon)
        configureColor()
    }
    
    func configureColor() {
        self.backgroundColor = isSelected ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : .clear
        self.layer.borderWidth = isSelected ? 0 : 1
        self.layer.borderColor = isSelected ? UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        self.title.textColor = isSelected ? .black : .white
        self.icon.tintColor = isSelected ? .black : .white
    }
}
