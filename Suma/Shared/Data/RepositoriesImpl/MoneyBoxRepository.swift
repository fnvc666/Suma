//
//  MoneyBoxRepository.swift
//  Suma
//
//  Created by Pavel Pavel on 25/08/2025.
//
import Foundation

final class MoneyBoxRepository: MoneyBoxRepositoryProtocol {
    private var items: [MoneyBox] = []
    
    func listAll() throws -> [MoneyBox] {
        items
    }
}
