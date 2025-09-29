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
    private var amount: Decimal = 0
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
        onAdded?()
    }
    
    func setType(_ type: String) {
        self.transactionType = type
    }
    func setAmount(_ amount: Decimal) {
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
