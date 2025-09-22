//
//  CategoriesRepository.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation
import CoreData

final class CategoriesRepositoryCoreData: CategoriesRepositoryProtocol {
    
    private let container: NSPersistentContainer
    private var items: [Category] = []
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func listAll() async throws -> [Category] {
        try await container.viewContext.perform {
            let req: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
            req.sortDescriptors = [NSSortDescriptor(key: "number", ascending: false)]
            let rows = try self.container.viewContext.fetch(req)
            return rows.map { $0.toDomain() }
        }
    }
    
    func get(by id: UUID) async throws -> Category {
        try await container.performBackgroundTask { ctx in
            let req: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
            req.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            req.fetchLimit = 1
            guard let obj = try ctx.fetch(req).first else { throw NSError() }
            return obj.toDomain()
        }
    }
    
    func create(_ category: Category) async throws {
        try await container.performBackgroundTask { ctx in
            let obj = CategoryEntity(context: ctx)
            obj.fill(from: category)
            try ctx.save()
        }
    }
    
    func update(_ category: Category) async throws {
        //
    }
    
    func delete(_ id: UUID) async throws {
        //
    }
}
