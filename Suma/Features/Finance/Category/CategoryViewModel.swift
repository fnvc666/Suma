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
    private(set) var category: Category
    
    init(categoryId: UUID, categories: CategoriesRepositoryProtocol, transactions: TransactionsRepositoryProtocol, initial: Category?) {
        self.categoryId = categoryId
        self.categories = categories
        self.transactions = transactions
        self.category = initial ?? Category(id: categoryId, number: "", name: "", budget: 0, current: 0, gradient: "GreenGradient", currency: "USD")
    }
    
    var onFetch: ((Category) -> Void)?
    // Outside navigation
    var onClose: (() -> Void)?
    var onEditCategory: (() -> Void)?
    var onAddCategory: (() -> Void)?
    var onAddTransaction: (() -> Void)?
    var onEditTransaction: ((UUID) -> Void)?
    
    // Inputs <- View
    func viewDidLoad() {
        print("INIT:", category)
        onFetch?(category)
        
        Task {
            if let actual = try? await categories.get(by: categoryId), actual != category {
                category = actual
                onFetch?(actual)
                print("FETCH:", category)
            }
        }
    }
    
    func closeTapped() { onClose?() }
    func editTapped() { onEditCategory?() }
    func deleteTapped() { // to add
        onClose?()
    }
    func editTransactionTapped(id: UUID) { onEditTransaction?(id)}
    func addTransactionTapped() { onAddTransaction?() }
}
