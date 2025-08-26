//
//  TransactionsRepository.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation
import CoreData

final class TransactionsRepositoryCoreData: TransactionsRepositoryProtocol {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    private var items: [Transaction] = []
    
    func listAll() throws -> [Transaction] {
        items
    }
    
    func add(_ tx: Transaction) throws {
        items.append(tx)
    }
    
    
}
