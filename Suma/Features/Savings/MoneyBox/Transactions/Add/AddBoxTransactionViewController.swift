//
//  AddBoxTransactionViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit

final class AddBoxTransactionViewController: UIViewController {
    private let vm: AddBoxTransactionViewModel
    
    init(viewModel: AddBoxTransactionViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
