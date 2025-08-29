//
//  AddTransactionViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import Foundation

final class AddTransactionViewModel {
    private let transactions: TransactionsRepositoryProtocol
    private let categoryId: UUID
    
    init(transactions: TransactionsRepositoryProtocol, categoryId: UUID) {
        self.transactions = transactions
        self.categoryId = categoryId
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onSaved: (() -> Void)?
    
    func savedTapped() { onSaved?() }
    func closeTapped() { onClose?() }
}
