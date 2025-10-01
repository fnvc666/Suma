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
    private(set) var transactionsList: [Transaction]
    
    var fetchTransactions: [Transaction] = []
    
    var onFetch: ((Category, [Transaction]) -> Void)?
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
        self.transactionsList = []
    }
    
    func viewDidLoad() {
        Task { @MainActor in onFetch?(category, transactionsList)
            print("CATEGORY1: \(category)")
            print("TRANS1: \(transactionsList)")
        }
        
        Task {
            do {
                let actual = try await categories.get(by: categoryId)
                let trans  = try await transactions.listAll(categoryId)
                
                await MainActor.run {
                    self.category = actual
                    self.transactionsList = trans
                    self.fetchTransactions = trans
                    
                    self.onFetch?(actual, trans)
                    print("CATEGORY (fresh): \(actual)")
                    print("TRANS (fresh): \(trans)")
                }
            } catch {
                print("Fetch error: \(error)")
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
