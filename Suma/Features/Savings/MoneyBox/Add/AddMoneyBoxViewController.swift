//
//  Untitled.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit

final class AddMoneyBoxViewController: UIViewController {
    private let vm: AddMoneyBoxViewModel
    
    init(viewModel: AddMoneyBoxViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        vm.viewDidLoad()
    }
}
