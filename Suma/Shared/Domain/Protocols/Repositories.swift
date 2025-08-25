//
//  Repositories.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

protocol TransactionsRepositoryProtocol {
    func listAll() throws -> [Transaction]
    func add(_ tx: Transaction) throws
}

protocol CategoriesRepositoryProtocol {
    func listAll() throws -> [Category]
}

protocol MoneyBoxRepositoryProtocol {
    func listAll() throws -> [MoneyBox]
}
