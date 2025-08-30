//
//  AddBoxTransaction.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//

final class AddBoxTransactionViewModel {
    private let transaction: MoneyBoxRepositoryProtocol
    
    init(transaction: MoneyBoxRepositoryProtocol) {
        self.transaction = transaction
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onAdd: (() -> Void)?
    
    func closeTapped() { onClose?() }
    func addTapped() { onAdd?() }
}
