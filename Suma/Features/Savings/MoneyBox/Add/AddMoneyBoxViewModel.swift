//
//  AddMoneyBoxViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//

final class AddMoneyBoxViewModel {
    private let savings: MoneyBoxRepositoryProtocol
    
    init(savings: MoneyBoxRepositoryProtocol) {
        self.savings = savings
    }
    
    
    // Outside inputs
    var onClose: (() -> Void)?
    var onSaved: (() -> Void)?
    
    func viewDidLoad() {}
    
    func closeTapped() { onClose?() }
    func saveTapped() { onSaved?() }
    
}
