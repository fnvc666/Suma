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
    }
    
    var onAddCategory: (() -> Void)?
    var onOpenCategory: ((UUID) -> Void)?
    
    // MARK: Outputs -> View
//    private(set) var state: HomeState = .init(
//        totalBalanceFormatted: "1.11",
//        selectedMonth: .april,
//        spendThisMonthBars: [50, 40, 30, 20, 10],
//        historyPoints: [6, 5, 8, 4, 3]
//    ) {
//        didSet { }
//    }
    
    // MARK: Input <- View
    func viewDidLoad() {
        
    }
    
    func addCategoryTapped() { onAddCategory?() }
    func categoryTapped(categoryId: UUID) { onOpenCategory?(categoryId) }
}
