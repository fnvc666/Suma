//
//  MoneyBoxRepository.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

final class MoneyBoxRepositoryCoreData: MoneyBoxRepositoryProtocol {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    private var items: [MoneyBox] = []
    
    func listAll() throws -> [MoneyBox] {
        items
    }
}
