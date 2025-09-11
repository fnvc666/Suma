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
    private let columnsHstack = UIStackView()
    
    private let spentMonthLabel = UILabel()
    private let monthDates = UILabel()
    private let augustColumns: [Column] = [
        .init(category: "Rent", amount: 500, maximum: 10, current: 3, badget: 1200),
        .init(category: "Food", amount: 250, maximum: 10, current: 4, badget: 300),
        .init(category: "Sports", amount: 55, maximum: 10, current: 5, badget: 100),
        .init(category: "Shops", amount: 100, maximum: 10, current: 6, badget: 300),
        .init(category: "Savings", amount: 700, maximum: 10, current: 7, badget: 500),
    ]
    private let septemberColumns: [Column] = [
        .init(category: "Rent",    amount: 600, maximum: 10, current: 6, badget: 1200),
        .init(category: "Food",    amount: 300, maximum: 10, current: 3, badget: 300),
        .init(category: "Sports",  amount: 500, maximum: 10, current: 5, badget: 100),
        .init(category: "Shops",   amount: 500, maximum: 10, current: 5, badget: 300),
        .init(category: "Savings", amount: 100, maximum: 10, current: 1, badget: 500),
    ]

    private let emptyColumns: [Column] = [
        .init(category: "Rent",    amount: 0, maximum: 10, current: 0, badget: 1200),
        .init(category: "Food",    amount: 0, maximum: 10, current: 0, badget: 300),
        .init(category: "Sports",  amount: 0, maximum: 10, current: 0, badget: 100),
        .init(category: "Shops",   amount: 0, maximum: 10, current: 0, badget: 300),
        .init(category: "Savings", amount: 0, maximum: 10, current: 0, badget: 500),
    ]

    private lazy var monthsSpend: [String : [Column]] = ["August": augustColumns, "September": septemberColumns]
    private lazy var currentMonthName: String = monthName(for: currentMonthNumber())
    private lazy var currentMonth: [Column] = monthsSpend[currentMonthName] ?? emptyColumns
    
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
        vstack.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        addSubview(vstack)
        
        // MARK: - Header
        headerHstack.axis = .horizontal
        headerHstack.alignment = .center
        
        spentMonthLabel.text = "Spent this month"
        spentMonthLabel.font = UIFont(name: "Geist-Medium", size: 18)
        spentMonthLabel.textColor = .white
        
        monthDates.text = "1 - 21 August"
        monthDates.font = UIFont(name: "Geist-Regular", size: 14)
        monthDates.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        let initial = currentMonthNumber()
        let pickerButton = MonthPickerButtonView(initialMonthIndex: initial, frame: .zero) { [weak self] month in
            guard let self else { return }
            let data = monthsSpend[month] ?? {
                self.monthsSpend[month] = self.emptyColumns
                return self.emptyColumns
            }()
            
            currentMonthName = month
            currentMonth = data
            monthDates.text = self.makeDatesLabel(for: month)
            reloadColumns(with: data)
        }
        pickerButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        pickerButton.widthAnchor.constraint(equalToConstant: 117).isActive = true
        pickerButton.layer.cornerRadius = 8
        pickerButton.layer.borderWidth = 1
        pickerButton.layer.masksToBounds = true
        pickerButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        
        headerHstack.addArrangedSubview(spentMonthLabel)
        headerHstack.addArrangedSubview(pickerButton)
        
        // MARK: - Columns
        columnsHstack.axis = .horizontal
        columnsHstack.isLayoutMarginsRelativeArrangement = true
        columnsHstack.directionalLayoutMargins = .init(top: 18, leading: 0, bottom: 0, trailing: 0)
        columnsHstack.distribution = .equalSpacing
        
        vstack.addArrangedSubview(headerHstack)
        vstack.addArrangedSubview(monthDates)
        vstack.addArrangedSubview(columnsHstack)
        
        vstack.setCustomSpacing(30, after: monthDates)
        [bg, vstack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bg.heightAnchor.constraint(equalToConstant: 370),
            
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
            let colView = ColumnView(frame: .zero, column: mon, mode: .spent)
            colView.widthAnchor.constraint(equalToConstant: 55).isActive = true
            columnsHstack.addArrangedSubview(colView)
        }
    }
    
    // MARK: - Helpers
    private func currentMonthNumber() -> Int {
        Calendar.current.component(.month, from: Date())
    }
    
    private func monthName(for number: Int) -> String {
        var df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        let idx = max(1, min(12, number)) - 1
        return df.monthSymbols[idx]
    }
    
    private func monthNumber(from name: String) -> Int {
        let map: [String: Int] = [
            "January": 1, "February": 2, "March": 3, "April": 4,
            "May": 5, "June": 6, "July": 7, "August": 8,
            "September": 9, "October": 10, "November": 11, "December": 12
        ]
        return map[name] ?? currentMonthNumber()
    }
    
    private func makeDatesLabel(for monthName: String) -> String {
        let cal = Calendar.current
        let year = cal.component(.year, from: Date())
        let month = monthNumber(from: monthName)
        
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = 1
        
        let date = cal.date(from: comps) ?? Date()
        let days = cal.range(of: .day, in: .month, for: date)?.count ?? 30
        return "1 - \(days) \(monthName)"
    }
}
