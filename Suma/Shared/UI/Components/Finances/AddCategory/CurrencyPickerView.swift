//
//  CurrencyPickerView.swift
//  Suma
//
//  Created by Pavel Pavel on 17/09/2025.
//
import UIKit

final class CurrencyPickerView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let button = UIButton()
    private let tableView = UITableView()
    private var isExpanded = false
    private var tableHeight: NSLayoutConstraint!
    
    private let currencies = [("USD", "usdFlagIcon"), ("EUR", "eurFlagIcon"), ("PLN", "plnFlagIcon")]
    
    var onCurrencySelected: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        tableView.layer.cornerRadius = 6
        tableView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.attributedTitle = AttributedString("USD ▾", attributes: AttributeContainer([
            .font: UIFont(name: "Geist-Medium", size: 14)!,
            .foregroundColor: UIColor.white
        ]))
        let image = UIImage(named: "usdFlagIcon")?.resized(to: CGSize(width: 20, height: 20))
        config.image = image
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
        let rows = currencies.count
        let target = isExpanded ? CGFloat(rows * 44) : 0
        
        UIView.animate(withDuration: 0.25) {
            self.tableHeight.constant = target
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTabelCell(style: .default, currency: currencies[indexPath.row].0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let (currency, icon) = currencies[indexPath.row]
        button.configuration = makeButtonConfig(title: "\(currency) ▾", imageName: icon)
        toggle()
        
        onCurrencySelected?(currency)
    }
    
    // MARK: - Helpers
    
    private func makeButtonConfig(title: String, imageName: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer([
            .font: UIFont(name: "Geist-Medium", size: 14)!,
            .foregroundColor: UIColor.white
        ]))
        
        let image = UIImage(named: imageName)?.resized(to: CGSize(width: 20, height: 20))
        config.image = image
        config.imagePlacement = .leading
        config.imagePadding = 8
        
        return config
    }

}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
