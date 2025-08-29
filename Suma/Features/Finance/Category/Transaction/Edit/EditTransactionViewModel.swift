//
//  EditTransactionViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import UIKit

final class EditTransactionViewModel {
    private let transaction: TransactionsRepositoryProtocol
    private let transactionId: UUID
    
    init(transaction: TransactionsRepositoryProtocol, transactionId: UUID) {
        self.transaction = transaction
        self.transactionId = transactionId
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onSaved: (() -> Void)?
    
    // Inputs <- View
    func viewDidLoad() {}
    
    func saveTapped() { onSaved?() }
    func closeTapped() { onClose?() }
    
}
