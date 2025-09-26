//
//  AddTransactionViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

class AddTransactionViewController: UIViewController {
    private let vm: AddTransactionViewModel
    private let navBar = CustomNavBar(frame: .zero, barTitle: "Add transaction")
    
    private let background = GradientBackgroundView(style: .card)
    private let scroll = UIScrollView()
    private let stack = UIStackView()
    
    private let transactionType = TransactionTypeView()
    
    init(viewModel: AddTransactionViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        buildComponents()
        setupCallbacks()
    }
    
    private func layout() {
        view.addSubview(background)
        view.addSubview(scroll)
        
        stack.axis = .vertical
        stack.alignment = .leading
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
            
            stack.topAnchor.constraint(equalTo: scroll.safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.safeAreaLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.safeAreaLayoutGuide.bottomAnchor),
            
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
        ])
    }
    
    private func buildComponents() {
        stack.arrangedSubviews.forEach {
            stack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        [navBar, transactionType].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            
            transactionType.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            transactionType.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
        ])
        
        stack.setCustomSpacing(32, after: navBar)
    }
    
    private func setupCallbacks() {
        navBar.onBack = { [weak vm] in
            vm?.closeTapped()
        }
    }
}
