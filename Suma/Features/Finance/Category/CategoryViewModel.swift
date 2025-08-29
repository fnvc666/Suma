//
//  CategoryViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import Foundation

final class CategoryViewModel {
    private let categoryId: UUID
    private let categories: CategoriesRepositoryProtocol
    private let transactions: TransactionsRepositoryProtocol
    
    init(categoryId: UUID, categories: CategoriesRepositoryProtocol, transactions: TransactionsRepositoryProtocol) {
        self.categoryId = categoryId
        self.categories = categories
        self.transactions = transactions
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onEditCategory: (() -> Void)?
    var onAddCategory: (() -> Void)?
    var onAddTransaction: (() -> Void)?
    var onEditTransaction: ((UUID) -> Void)?
    
    // Inputs <- View
    func viewDidLoad() {
        
    }
    
    func closeTapped() { onClose?() }
    func editTapped() { onEditCategory?() }
    func editTransactionTapped(id: UUID) { onEditTransaction?(id)}
    func addTransactionTapped() { onAddTransaction?() }
}
