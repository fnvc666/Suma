//
//  TotalBalanceView.swift
//  Suma
//
//  Created by Pavel Pavel on 02/09/2025.
//
import UIKit

final class TotalBalanceView: UIView {
    private let bg = UIImageView(image: UIImage(named: "totalBalanceBg"))
    private let vstack = UIStackView()
    private let hstack1 = UIStackView()
    private let totalTextLabel = UILabel()
    private let totalValueLabel = UILabel()
    private let reviewLabel = UILabel()
    private let statsLabel = UILabel()
    
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
        
        addSubview(vstack)
        vstack.axis = .vertical
        vstack.spacing = 6
        vstack.isLayoutMarginsRelativeArrangement = true
        vstack.directionalLayoutMargins = .init(top: 24, leading: 24, bottom: 24, trailing: 24)
        
        // MARK: - Row1
        hstack1.axis = .horizontal
        hstack1.alignment = .center
        
        totalTextLabel.text = "Total balance"
        totalTextLabel.font = UIFont(name: "Geist-Regular", size: 12)
        totalTextLabel.textColor = .gray
        
        let statsStack = UIStackView()
        statsStack.axis = .horizontal
        statsStack.spacing = 4
        
        let statsImage = UIImageView(image: UIImage(systemName: "chart.line.uptrend.xyaxis"))
        statsImage.tintColor = .black
        statsImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        statsImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        statsLabel.text = "+ 200$"
        statsLabel.font = UIFont(name: "Geist-SemiBold", size: 12)
        statsLabel.textColor = .black
        
        statsStack.addArrangedSubview(statsImage)
        statsStack.addArrangedSubview(statsLabel)
        statsStack.isLayoutMarginsRelativeArrangement = true
        statsStack.directionalLayoutMargins = .init(top: 4, leading: 10, bottom: 4, trailing: 10)
        statsStack.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.57)
        statsStack.layer.cornerRadius = 6
        statsStack.layer.masksToBounds = true
        
        hstack1.addArrangedSubview(totalTextLabel)
        hstack1.addArrangedSubview(statsStack)
        
        // MARK: - Row2
        totalValueLabel.text = "$2,250.00"
        totalValueLabel.font = UIFont(name: "Geist-SemiBold", size: 24)
        totalValueLabel.textColor = .black
        
        // MARK: - Row3
        
        reviewLabel.text = "Your budget has increased since last month"
        reviewLabel.font = UIFont(name: "Geist-Medium", size: 12)
        reviewLabel.textColor = .black
        
        vstack.addArrangedSubview(hstack1)
        vstack.addArrangedSubview(totalValueLabel)
        vstack.addArrangedSubview(reviewLabel)
        
        vstack.setCustomSpacing(24, after: totalValueLabel)
        
        [bg, vstack, hstack1].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bg.heightAnchor.constraint(equalToConstant: 150),
            
            vstack.topAnchor.constraint(equalTo: topAnchor),
            vstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vstack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
