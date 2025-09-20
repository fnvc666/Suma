//
//  Category.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

struct Category: Identifiable, Equatable {
    let id: UUID
    var number: String
    var name: String
    var budget: Double
    var current: Double
    var gradient: String
    var currency: String
}
