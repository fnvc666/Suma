//
//  Transaction+Mapping.swift
//  Suma
//
//  Created by Pavel Pavel on 30/09/2025.
//
import CoreData

extension TransactionEntity {
    func toDomain() -> Transaction {
        Transaction(
            id: id ?? UUID(),
            amount: amount,
            date: date ?? Date(),
            location: location,
            isSpent: isSpent,
            paymentMethod: paymentMethod,
            currency: currency,
            categoryId: categoryId
        )
    }
    
    func fill(from model: Transaction) {
        id = model.id
        amount = model.amount
        date = model.date
        isSpent = model.isSpent
        paymentMethod = model.paymentMethod
        location = model.location
        currency = model.currency
        categoryId = model.categoryId
    }
}
