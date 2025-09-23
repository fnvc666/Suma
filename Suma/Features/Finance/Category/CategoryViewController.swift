//
//  CategoryViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

final class CategoryViewController: UIViewController, UIGestureRecognizerDelegate {
    private let vm: CategoryViewModel
    private let navBar = MultiCustomNavBar(frame: .zero, barTitle: "Food")
    
    private let background = GradientBackgroundView(style: .screen)
    private let scroll = UIScrollView()
    private var stack = UIStackView()
    
    init(viewModel: CategoryViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDidLoad()
        layout()
        buildComponents()
        setupCallbacks()
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
        
        [navBar].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: stack.layoutMarginsGuide.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func setupCallbacks() {
        navBar.onBack = { [weak vm] in vm?.closeTapped() }
        navBar.onEdit = { [weak vm] in vm?.editTapped() }
        navBar.onDelete = { [weak vm] in vm?.deleteTapped() }
    }
}
