//
//  TransactionsRepository.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

final class TransactionsRepository: TransactionsRepositoryProtocol {
    private var items: [Transaction] = []
    
    func listAll() throws -> [Transaction] {
        items
    }
    
    func add(_ tx: Transaction) throws {
        items.append(tx)
    }
    
    
}
