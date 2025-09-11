//
//  BudgetHistoryView.swift
//  Suma
//
//  Created by Pavel Pavel on 02/09/2025.
//
import UIKit

final class BudgetHistoryView: UIView {
    private let bg = UIImageView(image: UIImage(named: "budgetHistory"))
    private let vstack = UIStackView()
    
    private let budgetHistory = UILabel()
    private let budgetResult = UILabel()
    private let monthHtack = UIStackView()
    private let maxBudgetHstack = UIStackView()
    private let maxBudgetLabel = UILabel()
    private var targetCenterX: NSLayoutXAxisAnchor?
    
    //temp
    private let lastSixMonth = [("Mar", 1200), ("Apr", 500), ("May", 1350), ("Jun", 2500), ("Jul", 1720), ("Aug", 2000)]
    
    private let budgetGraphic = GraphicView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(bg)
        bg.contentMode = .scaleAspectFill
        
        vstack.axis = .vertical
        vstack.spacing = 6
        vstack.isLayoutMarginsRelativeArrangement = true
        vstack.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        addSubview(vstack)
        
        // MARK: - Header
        budgetHistory.text = "Budget history"
        budgetHistory.font = UIFont(name: "Geist-Medium", size: 18)
        budgetHistory.textColor = .white
        
        budgetResult.text = "Budget growth/decline over the last\n6 months"
        budgetResult.font = UIFont(name: "Geist-Regular", size: 14)
        budgetResult.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        budgetResult.numberOfLines = 2
        
        // MARK: - Graphics
        
        budgetGraphic.heightAnchor.constraint(equalToConstant: 110).isActive = true
        let maxValue = lastSixMonth.map(\.1).max() ?? 1
        budgetGraphic.values = lastSixMonth.map { CGFloat($0.1) / CGFloat(maxValue) }
        
        monthHtack.axis = .horizontal
        monthHtack.alignment = .center
        monthHtack.distribution = .equalSpacing
        
        var maxBudget = 0
        for container in lastSixMonth {
            let month = UILabel()
            month.text = container.0
            month.textColor = .white
            month.font = UIFont(name: "Geist-Regular", size: 12)
            monthHtack.addArrangedSubview(month)
            
            if container.1 > maxBudget {
                maxBudget = container.1
                self.targetCenterX = month.centerXAnchor
            }
        }
        
        maxBudgetLabel.text = "\(maxBudget)$"
        maxBudgetLabel.textColor = .white
        maxBudgetLabel.font = UIFont(name: "Geist-Regular", size: 12)
        maxBudgetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        maxBudgetHstack.axis = .horizontal
        maxBudgetHstack.alignment = .center
        maxBudgetHstack.heightAnchor.constraint(equalToConstant: 16).isActive = true
        maxBudgetHstack.addSubview(maxBudgetLabel)
        
        [budgetHistory, budgetResult, maxBudgetHstack, budgetGraphic, monthHtack].forEach {
            vstack.addArrangedSubview($0)
        }
        
        
        [bg, vstack, maxBudgetLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        vstack.setCustomSpacing(40, after: budgetResult)
        
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bg.heightAnchor.constraint(equalToConstant: 320),
            
            maxBudgetLabel.centerXAnchor.constraint(equalTo: targetCenterX!, constant: 6),
            maxBudgetLabel.centerYAnchor.constraint(equalTo: maxBudgetHstack.centerYAnchor),
            
            vstack.topAnchor.constraint(equalTo: topAnchor),
            vstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
