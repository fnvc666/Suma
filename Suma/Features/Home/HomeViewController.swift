//
//  HomeViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

final class HomeViewController: UIViewController {
    private let vm: HomeViewModel
    
    private let background = GradientBackgroundView(style: .screen)
    private let scroll = UIScrollView()
    private let content = UIView()
    private let stack = UIStackView()
    
    init(viewModel: HomeViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        buildComponents()
    }
    
    private func layout() {
        view.addSubview(background)
        view.addSubview(scroll)
        scroll.addSubview(content)
        content.addSubview(stack)
        
        stack.axis = .vertical
        stack.spacing = 24
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = .init(top: 0, leading: 20, bottom: 10, trailing: 20)
        
        
        [background, scroll, content, stack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            content.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            content.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            
            content.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            
            stack.topAnchor.constraint(equalTo: content.topAnchor),
            stack.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: content.bottomAnchor),
        ])
    }
    
    private func buildComponents() {
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let header = MainHeaderView()
        header.onSettingsTap = { [weak self] in
            self?.vm.settingsTapped()
        }
        
        let totalBalance = TotalBalanceView()
        let spentThisMonth = SpendThisMonthView()
        
        [header, totalBalance, spentThisMonth].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }
        
        stack.setCustomSpacing(40, after: header)
    }
}
