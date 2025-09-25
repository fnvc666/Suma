//
//  ActionsView.swift
//  Suma
//
//  Created by Pavel Pavel on 24/09/2025.
//
import UIKit

final class ActionsView: UIView {
    private let hstack = UIStackView()
    private let addButton = CustomYellowButton()
    private let spacer = UIView()
    private let scanReceipt = CustomYellowButton()
    
    var onAddTransaction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError()}
    
    private func setupUI() {
        hstack.axis = .horizontal
        hstack.alignment = .center
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        addButton.configure("Add transaction", "plus")
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
    
        /// not available in beta. will be completed in future versions after release
        scanReceipt.configure("Scan Receipt", "barcode.viewfinder")
    
        
        [addButton, spacer, scanReceipt].forEach {
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
    
    @objc private func addClicked() {
        onAddTransaction?()
    }
}

final class CustomYellowButton: UIButton {
    private let hstack = UIStackView()
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
        backgroundColor = UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 1)
        layer.cornerRadius = 8
        
        hstack.axis = .horizontal
        hstack.spacing = 10
        hstack.isUserInteractionEnabled = false
        hstack.translatesAutoresizingMaskIntoConstraints = false
        hstack.isLayoutMarginsRelativeArrangement = true
        hstack.layoutMargins = .init(top: 6, left: 12, bottom: 6, right: 12)
        
        title.font = UIFont(name: "Geist-Medium", size: 14)
        title.textColor = .black
        
        icon.tintColor = .black
        [title, icon].forEach {
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
    }
}
