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
    
    private var transactionType = "Spent"
    private var amount: Double = 0
    private var location = ""
    private var currency = "USD"
    private var paymentMethod = "Card"
    init(transactions: TransactionsRepositoryProtocol, categoryId: UUID) {
        self.transactions = transactions
        self.categoryId = categoryId
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onAdded: (() -> Void)?
    
    func closeTapped() { onClose?() }
    
    func addTapped() {
        Task {
            do {
                let model = Transaction(
                    id: UUID(),
                    amount: amount,
                    date: Date(),
                    location: location,
                    isSpent: transactionType == "Spent",
                    paymentMethod: paymentMethod,
                    currency: currency,
                    categoryId: categoryId)
                
                try await transactions.add(model)
                await MainActor.run { onAdded?() }
            
            } catch {
                print("addTapped error:", error)
            }
        }
    }
    
    func setType(_ type: String) {
        self.transactionType = type
    }
    func setAmount(_ amount: Double) {
        self.amount = amount
    }
    
    func setLocation(_ location: String) {
        self.location = location
    }
    
    func setCurrency(_ currency: String) {
        self.currency = currency
    }
    
    func setPaymentMethods(_ method: String) {
        self.paymentMethod = method
    }
}
