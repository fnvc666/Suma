//
//  TransactionCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import UIKit

final class TransactionCoordinator: Coordinator {
    var children: [Coordinator] = []
    var onFinish: (() -> Void)?
    var onReload: (() -> Void)?
    
    private let transactions: TransactionsRepositoryProtocol
    private let nav: UINavigationController
    private let categoryId: UUID
    
    init(transactions: TransactionsRepositoryProtocol, nav: UINavigationController, categoryId: UUID) {
        self.transactions = transactions
        self.nav = nav
        self.categoryId = categoryId
    }
    
    func start() {
        //
    }
    
    func startAdd() {
        let vm = AddTransactionViewModel(
            transactions: transactions,
            categoryId: categoryId)
        let vc = AddTransactionViewController(viewModel: vm)
        vm.onClose = { [weak self] in
            self?.nav.popViewController(animated: true)
            self?.onFinish?()
        }
        vm.onAdded = { [weak self] in self?.close() }
        nav.pushViewController(vc, animated: true)
    }
    
    func startEdit(transactionId: UUID, snapshot: Transaction) {
        let vm = EditTransactionViewModel(
            transaction: transactions,
            transactionId: transactionId, initial: snapshot)
        let vc = EditTransactionViewController(viewModel: vm)
        vm.onClose = { [weak self] in self?.close() }
        vm.onSaved = { [weak self] in self?.close() }
        nav.pushViewController(vc, animated: true)
    }
    
    private func close() {
        nav.popViewController(animated: true)
        onReload?()
        onFinish?()
    }
}
