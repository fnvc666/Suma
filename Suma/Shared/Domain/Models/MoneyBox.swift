//
//  MoneyBox.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

struct MoneyBox: Identifiable, Equatable {
    let id: UUID
    var title: String
    var goal: Money
    var saved: Money
    var color: Int32
}
