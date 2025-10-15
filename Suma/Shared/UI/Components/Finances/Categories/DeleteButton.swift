//
//  DeleteButton.swift
//  Suma
//
//  Created by Pavel Pavel on 15/10/2025.
//
import UIKit

final class DeleteButton: UIButton {
    private let hstack = UIStackView()
    private let title = UILabel()
    private let icon = UIImageView()
    
    var onClicked: (() -> Void)?
    var titleText: String?
    
    init(frame: CGRect, title: String) {
        self.titleText = title
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
        
        title.font = UIFont(name: "Geist-Medium", size: 14)
        title.textColor = .black
        title.text = titleText
        
        icon.tintColor = .black
        icon.image = UIImage(systemName: "trash")
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
}
