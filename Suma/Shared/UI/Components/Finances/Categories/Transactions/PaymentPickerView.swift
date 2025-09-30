//
//  PaymentPickerView.swift
//  Suma
//
//  Created by Pavel Pavel on 28/09/2025.
//
import UIKit

final class PaymentPickerView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let button = UIButton()
    private let tableView = UITableView()
    private var isExpanded = false
    private var tableHeight: NSLayoutConstraint!
    
    private let methods = [("Card", "creditcard"), ("Cash", "dollarsign")]
    private var selectedMethod = "Card"
    
    var onMethodSelected: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.attributedTitle = AttributedString("By \(selectedMethod.lowercased()) ▾", attributes: AttributeContainer([
            .font: UIFont(name: "Geist-Medium", size: 14)!,
            .foregroundColor: UIColor.white
        ]))
        let image = UIImage(systemName: "creditcard")?.scaled(to: 0.85)?.withRenderingMode(.alwaysTemplate)
        config.image = image
        config.baseForegroundColor = .white
        config.imagePadding = 8
        
        button.configuration = config
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        tableHeight = tableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3),
            tableHeight,
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc private func toggle() {
        isExpanded.toggle()
        if isExpanded { tableView.isHidden = false }
        let rows = methods.count
        let target = isExpanded ? CGFloat(rows * 44) : 0
        
        UIView.animate(withDuration: 0.25) {
            self.tableHeight.constant = target
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomPaymentTableCell(style: .default, method: methods[indexPath.row].0, iconName: methods[indexPath.row].1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let (method, icon) = methods[indexPath.row]
        selectedMethod = method
        button.configuration = makeButtonConfig(title: "By \(method.lowercased()) ▾", imageName: icon)
        toggle()
        
        onMethodSelected?(method)
    }
    
    // MARK: - Helpers
    
    private func makeButtonConfig(title: String, imageName: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer([
            .font: UIFont(name: "Geist-Medium", size: 14)!,
            .foregroundColor: UIColor.white
        ]))
        
        let image = UIImage(systemName: imageName)?.scaled(to: 0.85)?.withRenderingMode(.alwaysTemplate)
        config.image = image
        config.baseForegroundColor = .white
        config.imagePlacement = .leading
        config.imagePadding = 8
        
        return config
    }
    
    func setMethod(_ code: String) {
        guard let index = methods.firstIndex(where: { $0.0 == code }) else { return }
        selectedMethod = code
        
        let pair = methods[index]
        button.configuration = makeButtonConfig(title: "\(pair.0) ▾", imageName: pair.1)
        
        tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
    }
}

extension UIImage {
    func scaled(to scale: CGFloat) -> UIImage? {
        let newSize = CGSize(width: size.width * scale,
                             height: size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

