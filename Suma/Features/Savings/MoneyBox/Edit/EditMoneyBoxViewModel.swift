//
//  EditMoneyBoxViewModel.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit

final class EditMoneyBoxViewModel {
    private let savings: MoneyBoxRepositoryProtocol
    private let boxId: UUID
    
    init(savings: MoneyBoxRepositoryProtocol, boxId: UUID) {
        self.savings = savings
        self.boxId = boxId
    }
    
    // Outside navigation
    var onClose: (() -> Void)?
    var onSave: (() -> Void)?
    
    // Inputs <- View
    func viewDidLoad() {}
    
    func closeTapped() { onClose?() }
    func saveTapped() { onSave?() }
}
