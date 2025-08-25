//
//  Transaction.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

struct Transaction: Identifiable, Equatable {
    let id: UUID
    var amount: Money
    var date: Date
    var note: String?
    var isExpense: Bool
    var categoryId: UUID?
}
