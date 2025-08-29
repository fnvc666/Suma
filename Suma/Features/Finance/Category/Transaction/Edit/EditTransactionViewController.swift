//
//  EditTransactionViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

class EditTransactionViewController: UIViewController {
    private let vm: EditTransactionViewModel
    
    init(viewModel: EditTransactionViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDidLoad()
    }
}
