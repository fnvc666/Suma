//
//  CategoriesView.swift
//  Suma
//
//  Created by Pavel Pavel on 11/09/2025.
//
import UIKit

final class CategoriesStatsView: UIView {
    private let bg = UIImageView(image: UIImage(named: "spentMonthGradient"))
    private let vstack = UIStackView()
    
    private let categoriesLabel = UILabel()
    private let columnsHstack = UIStackView()
    private let augustColumns: [Column] = [
        .init(category: "Rent", amount: 500, maximum: 10, current: 3, badget: 1200, number: "01", gradient: "BlueGradient"),
        .init(category: "Food", amount: 250, maximum: 10, current: 4, badget: 300, number: "02", gradient: "BlueGradient"),
        .init(category: "Sports", amount: 55, maximum: 10, current: 5, badget: 100, number: "03", gradient: "BlueGradient"),
        .init(category: "Shops", amount: 100, maximum: 10, current: 6, badget: 300, number: "04", gradient: "BlueGradient"),
        .init(category: "Savings", amount: 400, maximum: 10, current: 7, badget: 500, number: "05", gradient: "BlueGradient"),
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(bg)
        bg.contentMode = .scaleAspectFill
        
        vstack.axis = .vertical
        vstack.spacing = 0
        vstack.isLayoutMarginsRelativeArrangement = true
        vstack.directionalLayoutMargins = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
        addSubview(vstack)
        
        categoriesLabel.text = "Categories"
        categoriesLabel.textColor = .white
        categoriesLabel.font = UIFont(name: "Geist-Medium", size: 18)
        
        columnsHstack.axis = .horizontal
        columnsHstack.isLayoutMarginsRelativeArrangement = true
        columnsHstack.directionalLayoutMargins = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
        columnsHstack.distribution = .equalSpacing
        
        vstack.setCustomSpacing(40, after: categoriesLabel)
        
        [categoriesLabel, columnsHstack].forEach {
            vstack.addArrangedSubview($0)
        }
        
        [bg, vstack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bg.heightAnchor.constraint(equalToConstant: 340),
            
            vstack.topAnchor.constraint(equalTo: topAnchor),
            vstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        reloadColumns(with: augustColumns)
    }
    
    private func reloadColumns(with data: [Column]) {
        columnsHstack.arrangedSubviews.forEach { sub in
            columnsHstack.removeArrangedSubview(sub)
            sub.removeFromSuperview()
        }
        
        for mon in data {
            let colView = ColumnView(frame: .zero, column: mon, mode: .categories)
            colView.widthAnchor.constraint(equalToConstant: 55).isActive = true
            columnsHstack.addArrangedSubview(colView)
        }
    }
}
