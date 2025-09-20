//
//  CustomPlaceholder.swift
//  Suma
//
//  Created by Pavel Pavel on 17/09/2025.
//
import UIKit

final class CustomPlaceholder: UIView {
    
    var onTextChanged: ((String) -> Void)?
    
    var name: String = "" {
        didSet {
            if textfield.text != name {
                textfield.text = name
            }
        }
    }
    
    var contentType: ContentType
    var titleText: String
    var textfieldPlaceholder: String
    
    let stack = UIStackView()
    let title = UILabel()
    let textfield = UITextField()
    
    init(frame: CGRect, titleText: String, textfieldPlaceholder: String, contentType: ContentType) {
        self.contentType = contentType
        self.titleText = titleText
        self.textfieldPlaceholder = textfieldPlaceholder
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        title.text = titleText
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        title.font = UIFont(name: "Geist-Regular", size: 16)
        
        let pad = UIView(frame: .init(x: 0, y: 0, width: 12, height: 1))
        
        textfield.placeholder = textfieldPlaceholder
        textfield.attributedPlaceholder = NSAttributedString(
            string: textfieldPlaceholder,
            attributes: [
                .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6),
                .font: UIFont(name: "Geist-Regular", size: 14)!,
            ]
        )
        textfield.textColor = .white
        textfield.tintColor = .black
        textfield.text = name
        textfield.font = UIFont(name: "Geist-Regular", size: 14)
        textfield.leftView = pad
        textfield.leftViewMode = .always
        textfield.keyboardType = contentType == .text ? .default : .decimalPad
        textfield.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2).cgColor
        textfield.layer.cornerRadius = 6
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        textfield.addTarget(self, action: #selector(handleCahnged), for: .editingChanged)
        
        [title, textfield].forEach {
            stack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textfield.heightAnchor.constraint(equalToConstant: 36),
            textfield.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.8),
        ])
    }
    
    @objc private func handleCahnged(_ tf: UITextField) { onTextChanged?(tf.text ?? "")}
}

enum ContentType {
    case text
    case num
}
