//
//  CategoryViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

final class CategoryViewController: UIViewController, UIGestureRecognizerDelegate {
    private let vm: CategoryViewModel
    private let navBar = MultiCustomNavBar(frame: .zero, barTitle: "Categories")
    
    private let background = GradientBackgroundView(style: .screen)
    private let scroll = UIScrollView()
    private var stack = UIStackView()
    
    private let totalAmount = TotalAmountView()
    private let spentThisMonth = SpentThisMonthView()
    private let actionsView = ActionsView()
    private let transactionList = TransactionListView()
    
    init(viewModel: CategoryViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        buildComponents()
        setupCallbacks()
        rednerComponents()
        vm.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func layout() {
        view.addSubview(background)
        view.addSubview(scroll)
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = .init(top: 25, leading: 20, bottom: 20, trailing: 20)
        scroll.addSubview(stack)
        
        [background, scroll, stack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
        ])
    }

    private func buildComponents() {
        stack.arrangedSubviews.forEach {
            stack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        [navBar, totalAmount, spentThisMonth, actionsView, transactionList].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }

        stack.setCustomSpacing(32, after: navBar)
        stack.setCustomSpacing(36, after: totalAmount)
        stack.setCustomSpacing(24, after: spentThisMonth)
        stack.setCustomSpacing(24, after: actionsView)
    }
    
    private func setupCallbacks() {
        navBar.onBack = { [weak vm] in vm?.closeTapped() }
        navBar.onEdit = { [weak vm] in vm?.editTapped() }
        navBar.onDelete = { [weak vm] in vm?.deleteTapped() }
        actionsView.onAddTransaction = { [weak vm] in vm?.addTransactionTapped() }
        transactionList.onSelect = { [weak vm] id in vm?.editTransactionTapped(id: id)}
    }
    
    private func rednerComponents() {
        vm.onFetch = { [weak self] category, trans in
            self?.navBar.setBatTitle(category.name)
            self?.totalAmount.render(category.current, category.currency)
            self?.spentThisMonth.render(category.current, category.budget, category.currency, category.gradient)
            self?.transactionList.reload(with: trans)
        }
    }
}
