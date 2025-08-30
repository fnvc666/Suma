//
//  BoxTransactionCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit

enum BoxTransactionMode {
    case add, withdraw, edit
}

final class BoxTransactionCoordinator: Coordinator {
    var children: [Coordinator] = []
    var onFinish: (() -> Void)?
    
    private let savings: MoneyBoxRepositoryProtocol
    private let nav: UINavigationController
    private let boxId: UUID
    private let mode: BoxTransactionMode
    
    init(savings: MoneyBoxRepositoryProtocol, nav: UINavigationController, boxId: UUID, mode: BoxTransactionMode) {
        self.savings = savings
        self.nav = nav
        self.boxId = boxId
        self.mode = mode
    }
    
    func start() {
        switch mode {
            case .add: self.startAddTransaction()
            case .withdraw: self.startWithdrawTransaction()
            case .edit: self.startEditTransaction(id: UUID())
        }
    }
    
    private func startAddTransaction() {
        let vm = AddBoxTransactionViewModel(transaction: savings)
        let vc = AddBoxTransactionViewController(viewModel: vm)
        vm.onClose = { [weak self] in self?.close() }
        vm.onAdd = { [weak self] in self?.close() }
        nav.pushViewController(vc, animated: true)
    }
    
    private func startWithdrawTransaction() {
        let vm = WithdrawTransactionViewModel(savings: savings)
        let vc = WithdrawTransactionViewController(viewModel: vm)
        vm.onClose = { [weak self] in self?.close() }
        vm.onWithdraw = { [weak self] in self?.close() }
        nav.pushViewController(vc, animated: true)
    }
    
    private func startEditTransaction(id: UUID) {
        let vm = EditBoxTransactionViewModel(saving: savings, transactionId: id)
        let vc = EditBoxTransactionViewController(viewModel: vm)
    }
    
    private func close() {
        nav.popViewController(animated: true)
        onFinish?()
    }
}
