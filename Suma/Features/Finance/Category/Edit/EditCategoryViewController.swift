//
//  EditCategoryViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

class EditCategoryViewController: UIViewController, UIGestureRecognizerDelegate {
    private let vm: EditCategoryViewModel
    private let navBar = CustomNavBar(frame: .zero, barTitle: "Edit Category")
    
    private let background = GradientBackgroundView(style: .screen)
    private let scroll = UIScrollView()
    private let stack = UIStackView()
    private let headerHStack = UIStackView()
    private let saveButton = SaveChangesButton()
    private let folder: FolderView
    let form = FormSection()
    let gradients = GradientGridComponent()
    let spacer = UIView()
    
    init(viewModel: EditCategoryViewModel) {
        self.vm = viewModel
        self.folder = FolderView(frame: .zero, category: vm.draft)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        buildComponents()
        
        form.fill(from: vm.draft)
        gradients.select(name: vm.draft.gradient)
        folder.setGradient(vm.draft.gradient)
        
        form.onNameChanged = { [weak self] text in
            self?.vm.setName(text)
            self?.folder.setName(text)
        }
        form.onAmountChanged = { [weak self] text in
            self?.vm.setBudgetString(text)
            self?.folder.setAmount(text)
        }
        
        gradients.onSelect = { [weak self, weak vm] color in
            self?.vm.setGradient(color)
            self?.folder.setGradient(color)
        }
        
        saveButton.onSaveClicked = { [weak self] in
            self?.vm.saveTapped()
        }
        navBar.onBack = { [weak vm] in vm?.closeTapped() }
        
        vm.viewDidLoad()
//
//        form.onCurrencyChanged = { [weak self] currency in
//            self?.vm.setCurrency(currency)
//        }
//        
//        addButton.onAddClicked = { [weak self] in
//            self?.vm.addTapped()
//        }
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
            
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func buildComponents() {
        stack.arrangedSubviews.forEach {
            stack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        headerHStack.axis = .horizontal
        headerHStack.alignment = .center
        headerHStack.isLayoutMarginsRelativeArrangement = true
        
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        folder.translatesAutoresizingMaskIntoConstraints = false
        
        headerHStack.addArrangedSubview(folder)
        headerHStack.addArrangedSubview(spacer)
        headerHStack.addArrangedSubview(gradients)
        
        [navBar, headerHStack, form, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            
            headerHStack.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            headerHStack.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            
            folder.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) * 0.45),
            folder.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) * 0.45),
            
            form.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            form.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: form.bottomAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
            saveButton.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: stack.layoutMarginsGuide.bottomAnchor),
            
        ])
        
        stack.setCustomSpacing(32, after: navBar)
        stack.setCustomSpacing(25, after: headerHStack)
    }
}
