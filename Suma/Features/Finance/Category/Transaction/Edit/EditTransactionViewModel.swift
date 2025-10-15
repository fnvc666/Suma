//
//  EditTransactionViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import UIKit

final class EditTransactionViewModel {
    private let transactions: TransactionsRepositoryProtocol
    private let transactionId: UUID
    private(set) var draft: Transaction
    
    init(transaction: TransactionsRepositoryProtocol, transactionId: UUID, initial: Transaction) {
        self.transactions = transaction
        self.transactionId = transactionId
        self.draft = initial
    }
    
    var onClose: (() -> Void)?
    
    func closeTapped() { onClose?() }
    
    func saveTapped() {
        Task {
            do {
                let model = Transaction(
                    id: transactionId,
                    amount: draft.amount,
                    date: draft.date,
                    location: draft.location,
                    isSpent: draft.isSpent,
                    paymentMethod: draft.paymentMethod,
                    currency: draft.currency,
                    categoryId: draft.categoryId)
                
                try await transactions.update(model)
                await MainActor.run { onClose?() }
            
            } catch {
                print("saveTapped error:", error)
            }
        }
    }
    
    func deleteTapped() {
        Task {
            do {
                try await transactions.delete(transactionId)
                await MainActor.run { onClose?() }
            } catch {
                print("deleteTapped error:", error)
            }
        }
    }
    
    func setType(_ type: String) { self.draft.isSpent = type == "Spent" }
    func setAmount(_ amount: Double) { self.draft.amount = amount }
    func setLocation(_ location: String) { self.draft.location = location }
    func setCurrency(_ currency: String) { self.draft.currency = currency }
    func setPaymentMethods(_ method: String) { self.draft.paymentMethod = method }
}
