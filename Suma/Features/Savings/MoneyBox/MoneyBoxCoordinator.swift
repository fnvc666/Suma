//
//  MoneyBoxCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 29/08/2025.
//
import UIKit

final class MoneyBoxCoordinator: Coordinator {
    var children: [Coordinator] = []
    var onFinish: (() -> Void)?
    
    private var savings: MoneyBoxRepositoryProtocol
    private var nav: UINavigationController
    private var boxId: UUID
    
    init(savings: MoneyBoxRepositoryProtocol, nav: UINavigationController, boxId: UUID) {
        self.savings = savings
        self.nav = nav
        self.boxId = boxId
    }
    
    func start() {
        let vm = MoneyBoxViewModel(savings: savings, boxId: boxId)
        let vc = MoneyBoxViewController(viewModel: vm)
        
//        vc.onPopped
        vm.onClose = { [weak self] in
            self?.nav.popViewController(animated: true)
            self?.onFinish?()
        }
        vm.onEditBox = { [weak self] in
            self?.startEditBox()
        }
        vm.onAddMoney = { [weak self] in
            self?.startBoxTransactionCoordinator(mode: .add)
        }
        vm.onWithdraw = { [weak self] in
            self?.startBoxTransactionCoordinator(mode: .withdraw)
        }
        vm.onEditMoney = { [weak self] in
            self?.startBoxTransactionCoordinator(mode: .edit)
        }
    }
    
    private func startEditBox() {
        let vm = EditMoneyBoxViewModel(savings: savings, boxId: boxId)
        let vc = EditMoneyBoxViewController(viewModel: vm)
        
        vm.onClose = { [weak self] in
            self?.nav.popViewController(animated: true)
        }
        vm.onSave = { [weak self] in
            self?.nav.popViewController(animated: true)
        }
        nav.pushViewController(vc, animated: true)
    }
    
    private func startBoxTransactionCoordinator(mode: BoxTransactionMode) {
        let flow = BoxTransactionCoordinator(savings: savings, nav: nav, boxId: boxId, mode: mode)
        children.append(flow)
        flow.onFinish = { [weak self, weak flow] in
            guard let self, let flow else { return }
            self.children.removeAll { $0 === flow }
        }
    }
}
