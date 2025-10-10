//
//  EditTransactionViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

class EditTransactionViewController: UIViewController {
    private let vm: EditTransactionViewModel
    private let navBar = CustomNavBar(frame: .zero, barTitle: "Edit transaction")
    
    private let background = GradientBackgroundView(style: .card)
    private let scroll = UIScrollView()
    private let stack = UIStackView()
    
    private let transactionType = TransactionTypeView()
    private let amountView = TransactionAmountView()
    private let formSection = TransactionFormSectionView()
    private let saveTransactionButton = YellowButton(frame: .zero, title: "Save changes")
    
    init(viewModel: EditTransactionViewModel) {
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
        populateData()
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
        
        [navBar, transactionType, amountView, formSection, saveTransactionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            
            transactionType.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            transactionType.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            
            amountView.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            amountView.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            
            formSection.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            formSection.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            
            saveTransactionButton.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            saveTransactionButton.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            saveTransactionButton.bottomAnchor.constraint(equalTo: stack.layoutMarginsGuide.bottomAnchor),
        ])
        
        stack.setCustomSpacing(32, after: navBar)
        stack.setCustomSpacing(24, after: transactionType)
        stack.setCustomSpacing(24, after: amountView)
        stack.setCustomSpacing(24, after: formSection)
    }
    
    private func setupCallbacks() {
        navBar.onBack = { [weak vm] in vm?.closeTapped() }
        transactionType.onSetTransactionType = { [weak vm] type in vm?.setType(type) }
        formSection.onLocationChanged = { [weak vm] location in vm?.setLocation(location) }
        formSection.onPaymentMethodChanged = { [weak vm] method in vm?.setPaymentMethods(method) }
        formSection.onCurrencyChanged = { [weak vm] currency in vm?.setCurrency(currency) }
        saveTransactionButton.onClicked = { [weak vm] in vm?.saveTapped() }
        amountView.onAmountChanged = { [weak vm] amount in
            guard let amount = amount else { return }
            vm?.setAmount(amount)
        }
    }
    
    private func populateData() {
        print(vm.draft)
        transactionType.setType(vm.draft.isSpent)
        amountView.setAmount(vm.draft.amount)
        formSection.fill(vm.draft.location, vm.draft.paymentMethod, currency: vm.draft.currency)
    }
}
