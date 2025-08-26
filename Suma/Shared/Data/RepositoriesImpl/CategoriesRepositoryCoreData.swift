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
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    private var items: [Category] = []
    
    func listAll() throws -> [Category] {
        items
    }
}
