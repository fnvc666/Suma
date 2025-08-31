//
//  Untitled.swift
//  Suma
//
//  Created by Pavel Pavel on 31/08/2025.
//
import UIKit

final class MenuButton: UIControl {
    struct Model { let title: String; let icon: UIImage}
    
    private let stack = UIStackView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    
    private var model: Model?
    
    override var isSelected: Bool {
        didSet { updateSelection(animated: true) }
    }
    
    init() {
        super.init(frame: .zero)
        isExclusiveTouch = true
        layer.cornerCurve = .continuous
        layer.cornerRadius = 23
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(_ model: Model) {
        self.model = model
        iconView.image = model.icon.withRenderingMode(.alwaysTemplate)
        titleLabel.text = model.title
        updateSelection(animated: false)
    }
    
    private func setupUI() {
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        
        iconView.contentMode = .scaleAspectFit
        iconView.setContentHuggingPriority(.required, for: .horizontal)
        iconView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        titleLabel.font = .systemFont(ofSize: 14)
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(iconView)
        stack.addArrangedSubview(titleLabel)
        
        titleLabel.alpha = 0
        titleLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 46)
        ])
    }
    
    private func updateSelection(animated: Bool) {
        let apply = {
            self.titleLabel.isHidden = !self.isSelected
            self.titleLabel.alpha = self.isSelected ? 1 : 0
            // TODO: - colors
            self.iconView.tintColor = .green
            self.titleLabel.textColor = UIColor.black
        }
        
        if animated { UIView.animate(withDuration: 0.22, animations: apply) } else { apply() }
    }
}
