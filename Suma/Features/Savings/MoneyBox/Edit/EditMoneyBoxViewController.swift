//
//  EditMoneyBoxViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit

final class EditMoneyBoxViewController: UIViewController {
    private let vm: EditMoneyBoxViewModel
    
    init(viewModel: EditMoneyBoxViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDidLoad()
    }
    
}
