//
//  AddCategoryButton.swift
//  Suma
//
//  Created by Pavel Pavel on 18/09/2025.
//
import UIKit

final class AddCategoryButton: UIView {
    
    var onAddClicked: (() -> Void)?
    
    private let hstack = UIStackView()
    private let button = UIButton()
    
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
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("Add category", attributes: AttributeContainer([
            .font: UIFont(name: "Geist-Medium", size: 14)!,
            .foregroundColor: UIColor.black
        ]))
        button.configuration = config
        button.insetsLayoutMarginsFromSafeArea = true
        button.layoutMargins = .init(top: 6, left: 12, bottom: 6, right: 12)
        button.backgroundColor = UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 1)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        addSubview(hstack)
        hstack.addArrangedSubview(spacer)
        hstack.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            hstack.topAnchor.constraint(equalTo: topAnchor),
            hstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hstack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.widthAnchor.constraint(lessThanOrEqualTo: hstack.widthAnchor, multiplier: 0.35)
        ])
    }
    
    @objc private func clicked() {
        onAddClicked?()
    }
}
