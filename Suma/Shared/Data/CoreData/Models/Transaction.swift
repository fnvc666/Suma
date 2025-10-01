//
//  Transaction.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

struct Transaction: Hashable, Identifiable, Equatable {
    let id: UUID
    var amount: Double
    var date: Date
    var location: String
    var isSpent: Bool
    var paymentMethod: String
    var currency: String
    var categoryId: UUID
}
