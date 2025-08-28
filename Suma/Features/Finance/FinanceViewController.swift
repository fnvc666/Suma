//
//  FinanceViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

class FinanceViewController: UIViewController {
    private let vm: FinanceViewModel
    
    init(vm: FinanceViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDidLoad()
    }

}
