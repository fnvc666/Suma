//
//  SavingViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import Foundation

final class SavingViewModel {
    private let savings: MoneyBoxRepositoryProtocol
    
    init(savings: MoneyBoxRepositoryProtocol) {
        self.savings = savings
    }
    
    // Outside navigation
    var onAddMoneyBox: (() -> Void)?
    var onOpenMoneyBox: ((UUID) -> Void)?
    
    // Inputs <- View
    func viewDidLoad() {}
    func addMoneyBoxTapped() { onAddMoneyBox?() }
    func moneyBoxTapped(id: UUID) { onOpenMoneyBox?(UUID()) }
}
