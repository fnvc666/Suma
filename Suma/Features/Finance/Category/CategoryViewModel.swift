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
    
    var fetchTransactions: [Transaction] = []
    
    var onFetch: ((Category) -> Void)?
    var onClose: (() -> Void)?
    var onDelete: (() -> Void)?
    var onEditCategory: (() -> Void)?
    var onAddCategory: (() -> Void)?
    var onAddTransaction: (() -> Void)?
    var onEditTransaction: ((UUID, Transaction) -> Void)?
    
    init(categoryId: UUID, categories: CategoriesRepositoryProtocol, transactions: TransactionsRepositoryProtocol, initial: Category?) {
        self.categoryId = categoryId
        self.categories = categories
        self.transactions = transactions
        self.category = initial ?? Category(id: categoryId, number: "", name: "", budget: 0, current: 0, gradient: "GreenGradient", currency: "USD")
    }
    
    func viewDidLoad() {
        Task { @MainActor in onFetch?(category) }
        
        Task {
            if let actual = try? await categories.get(by: categoryId), actual != category {
                category = actual
                await MainActor.run { onFetch?(actual) }
            }
        }
    }
    
    func closeTapped() { onClose?() }
    func editTapped() { onEditCategory?() }
    func deleteTapped() {
        Task {
            do {
                try await categories.delete(categoryId)
                await MainActor.run { onDelete?() }
            } catch {
                print("error during deleting category: \(error)")
            }
        }
    }
    func editTransactionTapped(id: UUID) {
        if let snap = fetchTransactions.first(where: { $0.id == id }) {
            onEditTransaction?(id, snap)
        }
    }
    func addTransactionTapped() { onAddTransaction?() }
}
