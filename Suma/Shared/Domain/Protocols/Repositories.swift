//
//  Repositories.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

protocol TransactionsRepositoryProtocol {
    func listAll() async throws -> [Transaction]
    func add(_ tx: Transaction) throws
}

protocol CategoriesRepositoryProtocol {
    func listAll() async throws -> [Category]
    func get(by id: UUID) async throws -> Category
    func create(_ category: Category) async throws
    func update(_ category: Category) async throws
    func delete(_ id: UUID) async throws
}

protocol MoneyBoxRepositoryProtocol {
    func listAll() async throws -> [MoneyBox]
}
