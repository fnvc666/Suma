//
//  FinanceViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

class FinanceViewController: UIViewController {
    private let vm: FinanceViewModel
    
    private let background = GradientBackgroundView(style: .screen)
    private let scroll = UIScrollView()
    private let stack = UIStackView()
    
    private var grid: CategoryGridComponent!
    
    // temp
    private let augustColumns: [Column] = [
        .init(category: "Rent", amount: 500, maximum: 10, current: 3, badget: 1200, number: "01", gradient: "GreenGradient"),
        .init(category: "Food", amount: 250, maximum: 10, current: 4, badget: 300, number: "02", gradient: "BlueGradient"),
        .init(category: "Sports", amount: 55, maximum: 10, current: 5, badget: 100, number: "03", gradient: "OrangeGradient"),
        .init(category: "Shops", amount: 100, maximum: 10, current: 6, badget: 300, number: "04", gradient: "MintGradient"),
        .init(category: "Savings", amount: 400, maximum: 10, current: 7, badget: 500, number: "05", gradient: "RedGradient"),
    ]
    
    private var categories: [Category] = []
    
    init(viewModel: FinanceViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.onFetch = { [weak self] data in
            self?.categories = data
            self?.updateGrid(with: data)
        }
        categories = vm.fetchCategory
        layout()
        buildComponents()
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func layout() {
        view.addSubview(background)
        view.addSubview(scroll)
        
        scroll.addSubview(stack)
        
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        scroll.isDirectionalLockEnabled = true
        
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 24
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = .init(top: 0, leading: 20, bottom: 30, trailing: 20)
        
        [background, scroll, stack].forEach {
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
            
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func buildComponents() {
        stack.arrangedSubviews.forEach {
            stack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        let header = UILabel()
        header.text = "My Finances"
        header.textColor = .white
        header.font = UIFont(name: "Geist-Regular", size: 24)
        
        let totalBalance = TotalBalanceView()
        let categoriesStats = CategoriesStatsView()
        let addCategoryButton = AddNewCategoryButton()
        grid = CategoryGridComponent(items: categories, columns: 2)
        grid.onSelect = { [weak self] categoryId in
//            self?.vm.categoryTapped(categoryId: categoryId)
        }
        
        addCategoryButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        [header, totalBalance, categoriesStats, addCategoryButton, grid].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }
        stack.setCustomSpacing(32, after: header)
        
        NSLayoutConstraint.activate([
            grid.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            grid.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    @objc private func tap() {
        vm.addCategoryTapped()
        print("tapped")
    }
    
    private func updateGrid(with items: [Category]) {
        print("UPDATE")
        grid?.reload(with: items)
    }
}
