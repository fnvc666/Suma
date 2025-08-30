//
//  EditBoxTransactionViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit
final class EditBoxTransactionViewModel {
    private let saving: MoneyBoxRepositoryProtocol
    private let transactionId: UUID
    
    init(saving: MoneyBoxRepositoryProtocol, transactionId: UUID) {
        self.saving = saving
        self.transactionId = transactionId
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onSaved: (() -> Void)?
    
    // Input <- View
    func viewDidLoad() {}
    func closeTapped() { onClose?() }
    func saveTapped() { onSaved?() }
}
