//
//  CategoryCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import UIKit

final class CategoryCoordinator: Coordinator {
    var children: [Coordinator] = []
    var onFinish: (() -> Void)?
    var onReload: (() -> Void)?
    var onDelete: (() -> Void)?
    
    private let container: AppContainer
    private let nav: UINavigationController
    private let categoryId: UUID
    private let snapshot: Category?
    private let transactionFlow: TransactionCoordinator
    
    private var categoryVM: CategoryViewModel?
    
    init(container: AppContainer, nav: UINavigationController, categoryId: UUID, snapshot: Category?) {
        self.container = container
        self.nav = nav
        self.categoryId = categoryId
        self.snapshot = snapshot
        
        let flow = TransactionCoordinator(
            transactions: container.transactionRepo,
            nav: nav,
            categoryId: categoryId
        )
        self.transactionFlow = flow
        
        children.append(flow)
        flow.onFinish = { [weak self, weak flow] in
            guard let self, let flow else { return }
            self.children.removeAll { $0 === flow }
        }
    }
    
    func start() {
        let vm = CategoryViewModel(
            categoryId: categoryId,
            categories: container.categoriesRepo,
            transactions: container.transactionRepo, initial: snapshot
        )
        self.categoryVM = vm
        let vc = CategoryViewController(viewModel: vm)
        
        let transactionFlow = TransactionCoordinator(
            transactions: container.transactionRepo,
            nav: nav,
            categoryId: categoryId)
        
        children.append(transactionFlow)
        
        transactionFlow.onFinish = { [weak self, weak transactionFlow] in
            guard let self, let transactionFlow else { return }
            self.children.removeAll { $0 === transactionFlow }
        }
        
        vm.onClose = { [weak self] in
            self?.nav.popViewController(animated: true)
            self?.onFinish?()
        }
        
        vm.onEditCategory = { [weak self] in
            self?.startEditCategory()
        }
        
        vm.onDelete = { [weak self] in
            self?.onReload?()
            self?.nav.popViewController(animated: true)
        }
        
        vm.onAddTransaction = { [weak self] in
            self?.startAddTransaction()
        }
        
        vm.onEditTransaction = { [weak self] txId, snap in
            self?.startEditTransaction(id: txId, snap: snap)
        }
        
        nav.pushViewController(vc, animated: true)
    }
    
    private func startEditCategory() {
        let vm = EditCategoryViewModel(categoryId: categoryId, categories: container.categoriesRepo, initial: snapshot)
        let vc = EditCategoryViewController(viewModel: vm)
        nav.pushViewController(vc, animated: true)
        
        vm.onClose = { [weak self] in
            self?.nav.popViewController(animated: true)
        }
        
        vm.onSaved = { [weak self] in
            self?.nav.popViewController(animated: true)
            self?.onReload?()
        }
    }
    
    private func startAddTransaction() {
        transactionFlow.startAdd()
    }
    
    private func startEditTransaction(id: UUID, snap: Transaction) {
        transactionFlow.startEdit(transactionId: id, snapshot: snap)
        transactionFlow.onReload = { [weak self] in
            self?.categoryVM?.reload()
        }
    }
}
