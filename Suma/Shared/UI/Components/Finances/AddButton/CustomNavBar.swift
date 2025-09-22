//
//  CustomNavBar.swift
//  Suma
//
//  Created by Pavel Pavel on 12/09/2025.
//
import UIKit

final class CustomNavBar: UIView {
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    
    var barTitle: String
    
    var onBack: (() -> Void)?
    
    init(frame: CGRect, barTitle: String) {
        self.barTitle = barTitle
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        
        titleLabel.text = barTitle
        titleLabel.font = UIFont(name: "Geist-Regular", size: 24)
        titleLabel.textColor = .white
        
        [backButton, titleLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    @objc private func tapBack() {
        onBack?()
    }
}
