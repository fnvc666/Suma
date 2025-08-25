//
//  CategoriesRepository.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

final class CategoriesRepository: CategoriesRepositoryProtocol{
    private var items: [Category] = []
    
    func listAll() throws -> [Category] {
        items
    }
}
