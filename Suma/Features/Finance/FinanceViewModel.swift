//
//  FinanceViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import Foundation

final class FinanceViewModel {
    private let categories: CategoriesRepositoryProtocol
    private let transactions: TransactionsRepositoryProtocol
    
    init(categories: CategoriesRepositoryProtocol, transactions: TransactionsRepositoryProtocol) {
        self.categories = categories
        self.transactions = transactions
        Task { await load() }
    }
    var fetchCategory: [Category] = []
    
    var onAddCategory: (() -> Void)?
    var onOpenCategory: ((UUID, Category?) -> Void)?
    var onFetch: (([Category]) -> Void)? {
        didSet {
            DispatchQueue.main.async {
                self.onFetch?(self.fetchCategory)
            }
        }
    }
    
    // MARK: Input <- View
    func viewDidLoad() {}
    
    func addCategoryTapped() { onAddCategory?() }
    
    func categoryTapped(categoryId: UUID) {
        let snap = fetchCategory.first { $0.id == categoryId}
        onOpenCategory?(categoryId, snap) }
    
    func reload() { Task { await load()} }
    
    func load() async {
        do {
            let categories = try await self.categories.listAll()
            print("CATEGORIES: \(categories)")
            self.fetchCategory = categories
            await MainActor.run{ onFetch?(categories) }
        } catch {
            print("Error during fetching data: \(error)")
        }
    }
}
