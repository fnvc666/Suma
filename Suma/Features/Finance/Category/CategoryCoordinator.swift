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
    
    private let container: AppContainer
    private let nav: UINavigationController
    private let categoryId: UUID
    
    init(container: AppContainer, nav: UINavigationController, categoryId: UUID) {
        self.container = container
        self.nav = nav
        self.categoryId = categoryId
    }
    
    func start() {
        let vm = CategoryViewModel(
            categoryId: categoryId,
            categories: container.categoriesRepo,
            transactions: container.transactionRepo
            )
        let vc = CategoryViewController(viewModel: vm)
        vc.title = "Category"
//        vc.onPopped { [weak self] in
//            self?.onFinish?()
//        }
        
        vm.onClose = { [weak self] in
            self?.nav.popViewController(animated: true)
            self?.onFinish?()
        }
        
        vm.onEditCategory = { [weak self] in
            self?.startEditCategory()
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
        let vm = EditCategoryViewModel(categoryId: categoryId, categories: container.categoriesRepo)
        let vc = EditCategoryViewController(viewModel: vm)
        nav.pushViewController(vc, animated: true)
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
