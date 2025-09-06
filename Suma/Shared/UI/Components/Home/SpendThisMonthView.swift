//
//  SpendThisMonthView.swift
//  Suma
//
//  Created by Pavel Pavel on 02/09/2025.
//
import UIKit

final class SpendThisMonthView: UIView {
    private let bg = UIImageView(image: UIImage(named: "spentMonthGradient"))
    private let vstack = UIStackView()
    
    private let headerHstack = UIStackView()
    private let headerVStack = UIStackView()
    
    private let columnsHstack = UIStackView()
    
    private let spentMonthLabel = UILabel()
    private let monthDates = UILabel()
    private let columns: [Column] = [
        .init(category: "Rent", amount: "200", maximum: 10, current: 3),
        .init(category: "Food", amount: "300", maximum: 10, current: 4),
        .init(category: "Sports", amount: "400", maximum: 10, current: 5),
        .init(category: "Shops", amount: "500", maximum: 10, current: 6),
        .init(category: "Savings", amount: "600", maximum: 10, current: 7),
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        print("Setup UI for SpendThisMonthView")
        print("Screen bounds: \(UIScreen.main.bounds)")
        print("View frame: \(frame)")
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(bg)
        bg.contentMode = .scaleAspectFill
        
        vstack.axis = .vertical
        vstack.spacing = 20
        vstack.isLayoutMarginsRelativeArrangement = true
        vstack.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        addSubview(vstack)
        
        // MARK: - Header
        headerHstack.axis = .horizontal
        
        headerVStack.axis = .vertical
        headerVStack.spacing = 6
        
        spentMonthLabel.text = "Spent this month"
        spentMonthLabel.font = UIFont(name: "Geist-Medium", size: 18)
        spentMonthLabel.textColor = .white
        
        monthDates.text = "1 - 21 August"
        monthDates.font = UIFont(name: "Geist-Regular", size: 14)
        monthDates.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        headerVStack.addArrangedSubview(spentMonthLabel)
        headerVStack.addArrangedSubview(monthDates)
        
        // MARK: - Columns
        columnsHstack.axis = .horizontal
        columnsHstack.isLayoutMarginsRelativeArrangement = true
        columnsHstack.directionalLayoutMargins = .init(top: 18, leading: 0, bottom: 0, trailing: 0)
        columnsHstack.distribution = .equalSpacing
        
        for col in columns {
            let colView = ColumnView(frame: .zero, column: col)
            colView.widthAnchor.constraint(equalToConstant: 55).isActive = true
            columnsHstack.addArrangedSubview(colView)
        }
        
        vstack.addArrangedSubview(headerVStack)
        vstack.addArrangedSubview(columnsHstack)
        
        [bg, vstack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bg.heightAnchor.constraint(equalToConstant: 350),
            
            vstack.topAnchor.constraint(equalTo: topAnchor),
            vstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// temp
struct Column {
    let category: String
    let amount: String
    let maximum: Int
    let current: Int
}

final class ColumnView: UIView {
    private let column: Column
    private let vstack = UIStackView()
    private let maxColumnLabel = UILabel()
    private let fillColumnLabel = UILabel()
    private let categoryLabel = UILabel()
    private let amountLabel = UILabel()
    
    init(frame: CGRect, column: Column) {
        self.column = column
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(vstack)
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.spacing = 5
        vstack.translatesAutoresizingMaskIntoConstraints = false
        
        maxColumnLabel.backgroundColor = UIColor(red: 0.871, green: 0.859, blue: 0.8, alpha: 0.2)
        maxColumnLabel.layer.cornerRadius = 9
        maxColumnLabel.layer.masksToBounds = true
        maxColumnLabel.heightAnchor.constraint(equalToConstant: 160).isActive = true
        maxColumnLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        fillColumnLabel.backgroundColor = UIColor(red: 0.949, green: 1, blue: 0.345, alpha: 1)
        fillColumnLabel.layer.cornerRadius = 9
        fillColumnLabel.layer.masksToBounds = true
        let cur = CGFloat(column.current) / CGFloat(column.maximum) * 160
        fillColumnLabel.heightAnchor.constraint(equalToConstant: cur).isActive = true
        fillColumnLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        fillColumnLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.text = column.category
        categoryLabel.textColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 0.6)
        categoryLabel.font = UIFont(name: "Geist-Regular", size: 12)
        
        amountLabel.text = "\(column.amount)$"
        amountLabel.textColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1)
        amountLabel.font = UIFont(name: "Geist-Semibold", size: 12)
        
        maxColumnLabel.addSubview(fillColumnLabel)
        vstack.addArrangedSubview(maxColumnLabel)
        vstack.addArrangedSubview(categoryLabel)
        vstack.addArrangedSubview(amountLabel)
        
        vstack.setCustomSpacing(26, after: maxColumnLabel)
        
        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: topAnchor),
            vstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            fillColumnLabel.leadingAnchor.constraint(equalTo: maxColumnLabel.leadingAnchor),
            fillColumnLabel.trailingAnchor.constraint(equalTo: maxColumnLabel.trailingAnchor),
            fillColumnLabel.bottomAnchor.constraint(equalTo: maxColumnLabel.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
   
}
