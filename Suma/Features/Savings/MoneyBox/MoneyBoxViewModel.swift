//
//  MoneyBoxViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit

final class MoneyBoxViewModel {
    private let savings: MoneyBoxRepositoryProtocol
    private let boxId: UUID
    
    init(savings: MoneyBoxRepositoryProtocol, boxId: UUID) {
        self.savings = savings
        self.boxId = boxId
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onEditBox: (() -> Void)?
    var onAddMoney: (() -> Void)?
    var onWithdraw: (() -> Void)?
    var onEditMoney: (() -> Void)?
    
    // Inputs <- View
    func viewDidLoad() {}
    func closeTapped() { onClose?() }
    func editTapped() { onEditBox?() }
    func addTapped() { onAddMoney?() }
    func withdrawTapped() { onWithdraw?() }
}
