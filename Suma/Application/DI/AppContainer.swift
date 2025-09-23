//
//  AppContainer.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation
import CoreData

// Composition root
final class AppContainer {
    let persistent: NSPersistentContainer
    let transactionRepo: TransactionsRepositoryProtocol
    let categoriesRepo: CategoriesRepositoryProtocol
    let moneyBoxRepo: MoneyBoxRepositoryProtocol
    
    init() {
        // Core data
        persistent = NSPersistentContainer(name: "Suma")
        persistent.loadPersistentStores { _, error in
            precondition(error == nil, "CD load error: \(error!)")
        }
        persistent.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        persistent.viewContext.automaticallyMergesChangesFromParent = true
        
        // Repositories (CoreData impl)
        let cd = persistent
        transactionRepo = TransactionsRepositoryCoreData(container: persistent)
        categoriesRepo = CategoriesRepositoryCoreData(container: persistent)
        moneyBoxRepo = MoneyBoxRepositoryCoreData(container: persistent)
    }
}
