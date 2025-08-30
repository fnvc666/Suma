//
//  SavingsCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//
import UIKit

final class SavingsCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    private let container: AppContainer
    private let nav: UINavigationController
    
    init(container: AppContainer, nav: UINavigationController) {
        self.container = container
        self.nav = nav
    }
    
    func start() {
        let vm = SavingViewModel(savings: container.moneyBoxRepo)
        let vc = SavingViewController(viewModel: vm)
        
        nav.setViewControllers([vc], animated: false)
        
        vm.onAddMoneyBox = { [weak self] in
            self?.startAddMoneyBox()
        }
        
        vm.onOpenMoneyBox = { [weak self] txId in
            self?.startMoneyBox(id: txId)
        }
    }
    
    private func startAddMoneyBox() {
        let vm = AddMoneyBoxViewModel(savings: container.moneyBoxRepo)
        let vc = AddMoneyBoxViewController(viewModel: vm)
        vm.onClose = { [weak self] in self?.nav.popViewController(animated: true) }
        vm.onSaved = { [weak self] in self?.nav.popViewController(animated: true) }
        nav.pushViewController(vc, animated: true)
    }
    
    private func startMoneyBox(id: UUID) {
        let flow = MoneyBoxCoordinator(
            savings: container.moneyBoxRepo,
            nav: nav, boxId: id)
        children.append(flow)
        flow.onFinish = { [weak self, weak flow] in
            guard let self, let flow else { return }
            self.children.removeAll { $0 === flow }
        }
        flow.start()
    }
    
    
}
