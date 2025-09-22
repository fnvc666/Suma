//
//  FinanceCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//
import UIKit

final class FinanceCoordinator: Coordinator {
    var children: [Coordinator] = []
    private var container: AppContainer
    private var nav: UINavigationController
    
    private var financeVM: FinanceViewModel?
    
    init(container: AppContainer, nav: UINavigationController) {
        self.container = container
        self.nav = nav
    }
    
    func start() {
        let vm = FinanceViewModel(categories: container.categoriesRepo, transactions: container.transactionRepo)
        self.financeVM = vm
        let vc = FinanceViewController(viewModel: vm)
        nav.setViewControllers([vc], animated: false)
        
        vm.onAddCategory = { [weak self] in
            self?.startAddCategory()
        }
        
        vm.onOpenCategory = { [weak self] id, snap in
            self?.startCategory(categoryId: id, snapshot: snap)
        }
        
        
    }
    
    private func startAddCategory() {
        let vm = AddCategoryViewModel(categories: container.categoriesRepo)
        let vc = AddCategoryViewController(viewModel: vm)
        vc.loadViewIfNeeded()
        vm.onClose = { [weak self] in
            self?.nav.popViewController(animated: true)
        }
        
        vm.onAdded = { [weak self] in
            self?.nav.popViewController(animated: true)
            self?.financeVM?.reload()
        }
        
        self.nav.pushViewController(vc, animated: true)
    }
    
    private func startCategory(categoryId: UUID, snapshot: Category?) {
        let flow = CategoryCoordinator(container: container, nav: nav, categoryId: categoryId, snapshot: snapshot)
        children.append(flow)
        flow.onFinish = { [weak self, weak flow] in
            guard let self, let flow else { return }
            self.children.removeAll { $0 === flow }
        }
        flow.start()
    }
}
