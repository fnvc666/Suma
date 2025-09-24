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
    
    init(container: AppContainer, nav: UINavigationController, categoryId: UUID, snapshot: Category?) {
        self.container = container
        self.nav = nav
        self.categoryId = categoryId
        self.snapshot = snapshot
    }
    
    func start() {
        let vm = CategoryViewModel(
            categoryId: categoryId,
            categories: container.categoriesRepo,
            transactions: container.transactionRepo, initial: snapshot
            )
        let vc = CategoryViewController(viewModel: vm)
        
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
        
        vm.onEditTransaction = { [weak self] txId in
            self?.startEditTransaction(id: txId)
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
        let flow = TransactionCoordinator(
            transactions: container.transactionRepo,
            nav: nav,
            categoryId: categoryId)
        children.append(flow)
        flow.onFinish = { [weak self, weak flow] in
            guard let self, let flow else { return }
            self.children.removeAll { $0 === flow }
        }
        flow.startAdd()
    }
    
    private func startEditTransaction(id: UUID) {
        let flow = TransactionCoordinator(
            transactions: container.transactionRepo,
            nav: nav,
            categoryId: categoryId)
        children.append(flow)
        flow.onFinish = { [weak self, weak flow] in
            guard let self, let flow else { return }
            self.children.removeAll { $0 === flow }
        }
        flow.startEdit(transactionId: id)
    }
}
