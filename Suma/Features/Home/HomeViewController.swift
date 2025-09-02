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
    private let stack = UIStackView()
    
    init(viewModel: HomeViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
