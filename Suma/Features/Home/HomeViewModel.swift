//
//  HomeViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import Foundation

enum Month: String, CaseIterable {
    case january, february, march, april, may, june, july, august, september, october, november, december
}

struct HomeState {
    var totalBalanceFormatted: String
    var selectedMonth: Month
    var spendThisMonthBars: [Int]
    var historyPoints: [Int]
}

final class HomeViewModel {
    private let transactions: TransactionsRepositoryProtocol
    
    init(transactions: TransactionsRepositoryProtocol) {
        self.transactions = transactions
    }
    
    // MARK: Outputs -> View
    private(set) var state: HomeState = .init(
    totalBalanceFormatted: "0.00",
    selectedMonth: .august,
    spendThisMonthBars: [10, 20, 30, 40, 50],
    historyPoints: [3, 4, 8, 5, 6]
    ) {
        didSet { onStateChanged?(state) }
    }
    var onStateChanged: ((HomeState) -> Void)?
    
    var onSettingsRequested: (() -> Void)?
    
    // MARK: Inputs <- View
    func viewDidLoad() {
        onStateChanged?(state)
    }
    
    func monthPickerChanged(to month: Month) {
        state.selectedMonth = month
    }
    
    func settingsTapped() {
        onSettingsRequested?()
    }
}
