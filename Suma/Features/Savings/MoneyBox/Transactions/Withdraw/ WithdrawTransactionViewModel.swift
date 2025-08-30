//
//   WithdrawTransactionViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit

final class WithdrawTransactionViewModel {
    private let savings: MoneyBoxRepositoryProtocol
    
    init(savings: MoneyBoxRepositoryProtocol) {
        self.savings = savings
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onWithdraw: (() -> Void)?
    
    // Inputs <- View
    func closeTapped() { onClose?() }
    func withdrawTapped() { onWithdraw?() }
}
