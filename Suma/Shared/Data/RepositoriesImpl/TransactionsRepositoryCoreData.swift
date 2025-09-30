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
    
    func listAll() async throws -> [Transaction] {
        try await container.viewContext.perform {
            let req: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
            let rows = try self.container.viewContext.fetch(req)
            return rows.map { $0.toDomain() }
        }
    }
    
    func add(_ tx: Transaction) async throws {
        try await container.performBackgroundTask { ctx in
            let obj = TransactionEntity(context: ctx)
            obj.fill(from: tx)
            try ctx.save()
        }
    }
    
}
