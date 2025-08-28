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
    
    init(container: AppContainer, nav: UINavigationController) {
        self.container = container
        self.nav = nav
    }
    
    func start() {
        let vm = FinanceViewModel(categories: container.categoriesRepo, transactions: container.transactionRepo)
        let vc = FinanceViewController(vm: vm)
        vc.title = "Finance"
        nav.setViewControllers([vc], animated: false)
        
        vm.onAddCategory = { [weak self] in
            self?.startAddCategory()
        }
        
        vm.onOpenCategory = { [weak self] categoryId in
            self?.startCategory(categoryId: categoryId)
        }
        
        
    }
    
    private func startAddCategory() {
        let vm = AddCategoryViewModel(categories: container.categoriesRepo)
        let vc = AddCategoryViewController(viewModel: vm)
        nav.pushViewController(vc, animated: true)
    }
    
    private func startCategory(categoryId: UUID) {
        let flow = CategoryCoordinator(container: container, nav: nav, categoryId: categoryId)
        
        children.append(flow)
        flow.onFinish = { [weak self, weak flow] in
            guard let self, let flow else { return }
            self.children.removeAll { $0 === flow }
        }
        flow.start()
    }
}
