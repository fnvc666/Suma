//
//  HomeCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//
import UIKit

final class HomeCoordinator: Coordinator {
    var children: [Coordinator] = []
    private let container: AppContainer
    private let nav: UINavigationController
    
    init(container: AppContainer, nav: UINavigationController) {
        self.container = container
        self.nav = nav
    }
    
    func start() {
        let vm = HomeViewModel(transactions: container.transactionRepo)
        let vc = HomeViewController(viewModel: vm)
        nav.setViewControllers([vc], animated: false)
        
        vm.onSettingsRequested = { [weak self] in
            self?.startSettings()
        }
    }
    
    private func startSettings() {
        let flow = SettingsCoordinator(nav: nav)
        children.append(flow)
        flow.onFinish = { [weak self, weak flow] in
            guard let flow else { return }
            self?.children.removeAll { $0 === flow}
        }
        flow.start()
    }
}
