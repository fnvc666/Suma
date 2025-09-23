//
//  MultiCustomNavBar.swift
//  Suma
//
//  Created by Pavel Pavel on 22/09/2025.
//
import UIKit

final class MultiCustomNavBar: UIView {
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let moreButton = UIButton()
    
    var barTitle: String
    
    var onBack: (() -> Void)?
    var onEdit: (() -> Void)?
    var onDelete: (() -> Void)?
    
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
        
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .white
        moreButton.showsMenuAsPrimaryAction = true
        menuSetup()
        
        [backButton, titleLabel, moreButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            moreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 28),
            moreButton.widthAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    private func menuSetup() {
        let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { [weak self] _ in
            self?.onEdit?()
        }
        
        let delete = UIAction(title: "Delete category", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
            self?.onDelete?()
        }
        
        moreButton.menu = UIMenu(children: [edit, delete])
    }
    
    @objc private func tapBack() {
        onBack?()
    }
}

