//
//  HomeViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

final class HomeViewController: UIViewController {
    private let vm: HomeViewModel
    
    // UI
    private let balanceLabel = UILabel()
    private let monthControl = UISegmentedControl(items: Month.allCases.map { $0.rawValue.capitalized })
    private let barsView = UIView()
    private let historyView = UIView()
    
    init(viewModel: HomeViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home1"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(onSettings)
        )
        
        layout()
        bind()
        vm.viewDidLoad()
    }
    
    private func layout() {
        [balanceLabel, monthControl, barsView, historyView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            balanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            balanceLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            
            monthControl.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 16),
            monthControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            monthControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            barsView.topAnchor.constraint(equalTo: monthControl.bottomAnchor, constant: 24),
            barsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            barsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            barsView.heightAnchor.constraint(equalToConstant: 180),
            
            historyView.topAnchor.constraint(equalTo: barsView.bottomAnchor, constant: 24),
            historyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            historyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            historyView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            historyView.heightAnchor.constraint(equalToConstant: 180),
        ])
        
        barsView.backgroundColor = .gray
        historyView.backgroundColor = .lightGray
        
        monthControl.selectedSegmentIndex = Month.allCases.firstIndex(of: .august) ?? 0
        monthControl.addTarget(self, action: #selector (onMonthChanged), for: .valueChanged)
    }
    
    private func bind() {
        vm.onStateChanged = { [weak self] state in
            self?.balanceLabel.text = state.totalBalanceFormatted
            if let idx = Month.allCases.firstIndex(of: state.selectedMonth) {
                self?.monthControl.selectedSegmentIndex = idx
            }
        }
    }
    
    @objc private func onSettings() { vm.settingsTapped() }
    @objc private func onMonthChanged(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        guard Month.allCases.indices.contains(idx) else { return }
        vm.monthPickerChanged(to: Month.allCases[idx])
    }
}
