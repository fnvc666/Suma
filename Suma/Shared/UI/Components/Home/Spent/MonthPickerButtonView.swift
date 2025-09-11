//
//  MonthPickerView.swift
//  Suma
//
//  Created by Pavel Pavel on 07/09/2025.
//

import UIKit

final class MonthPickerButtonView: UIView {
    var monthAndIndex: [(String, Int)] = [
        ("January", 1), ("February", 2), ("March", 3), ("April", 4),
        ("May", 5), ("June", 6), ("July", 7), ("August", 8),
        ("September", 9), ("October", 10), ("November", 11), ("December", 12),
    ]
    
    private var selectedRow: Int = 0 { didSet { updateUI() } }
    
    var selectedMonthIndex: Int { monthAndIndex[selectedRow].1 }
    
    var onChange: (String) -> Void

    // MARK: - UI
    private let button = UIButton()
    private let titleLabel = UILabel()
    
    // MARK: - Init
    init(initialMonthIndex: Int? = nil, frame: CGRect, onChange: @escaping (String) -> Void) {
        self.onChange = onChange
        super.init(frame: frame)
        setupUI()
        
        if let num = initialMonthIndex,
           let row = monthAndIndex.firstIndex(where: { $0.1 == num }) {
            selectedRow = row
        } else {
            selectedRow = 0
        }
        updateUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setMonths(_ months: [(String, Int)], selected: Int) {
        self.monthAndIndex = months
        if let row = months.firstIndex(where: { $0.1 == selected }) {
            self.selectedRow = row
        } else {
            self.selectedRow = 0
        }
        updateUI()
    }
    
    func setSelected(monthNumber: Int) {
        if let row = monthAndIndex.firstIndex(where: { $0.1 == monthNumber }) {
            selectedRow = row
        }
    }
    
    private func updateUI() {
        guard monthAndIndex.indices.contains(selectedRow) else { return }
        titleLabel.text = monthAndIndex[selectedRow].0
    }
    
    private func setupUI() {
        addSubview(button)
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Geist-Regular", size: 12)
        
        let image = UIImageView(image: UIImage(systemName: "chevron.down"))
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        image.heightAnchor.constraint(equalToConstant: 16).isActive = true
        image.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.alignment = .fill
        hstack.spacing = 6
        hstack.isUserInteractionEnabled = false
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        hstack.addArrangedSubview(titleLabel)
        hstack.addArrangedSubview(image)
        
        button.addSubview(hstack)
        button.backgroundColor = UIColor(white: 1, alpha: 0.05)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openPicker), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            hstack.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
            hstack.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
            hstack.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            hstack.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -8),
        ])
    }
    
    @objc private func openPicker() {
        if NSClassFromString("UISheetPresentationController") != nil, #available(iOS 15.0, *) {
            let vc = MonthPickerSheetVC(
                months: monthAndIndex,
                selectedIndex: selectedRow
            ) { [weak self] idx in
                guard let self else { return }
                self.selectedRow = idx
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                self.onChange(self.monthAndIndex[idx].0)
            }
            parentViewController?.present(vc, animated: true)
            return
        }
        
        let ac = UIAlertController(title: "Select month", message: nil, preferredStyle: .actionSheet)
        for (idx, item) in monthAndIndex.enumerated() {
            let action = UIAlertAction(title: item.0, style: .default) { [weak self] _ in
                guard let self else { return }
                self.selectedRow = idx
                self.onChange(item.0)
            }
            ac.addAction(action)
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        parentViewController?.present(ac, animated: true)
    }
}

// MARK: - Find parent VC
private extension UIView {
    var parentViewController: UIViewController? {
        sequence(first: self.next, next: { $0?.next }).first { $0 is UIViewController } as? UIViewController
    }
}
