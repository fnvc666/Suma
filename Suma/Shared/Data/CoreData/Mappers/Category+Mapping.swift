//
//  Category+Mapping.swift
//  Suma
//
//  Created by Pavel Pavel on 20/09/2025.
//
import CoreData

extension CategoryEntity {
    func toDomain() -> Category {
        Category(
            id: id ?? UUID(),
            number: number ?? "99",
            name: name ?? "",
            budget: budget,
            current: current,
            gradient: gradient ?? "GreenGradient",
            currency: currency ?? "USD")
    }
    
    func fill(from model: Category) {
        id = model.id
        number = model.number
        name = model.name
        budget = model.budget
        current = model.current
        gradient = model.gradient
        currency = model.currency
    }
}
