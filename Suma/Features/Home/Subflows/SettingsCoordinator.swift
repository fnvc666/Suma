//
//  SettingsCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import UIKit

final class SettingsCoordinator: Coordinator {
    var children: [Coordinator] = []
    var onFinish: (() -> Void)?
    
    private let nav: UINavigationController
    
    init(nav: UINavigationController) {
        self.nav = nav
    }
    
    func start() {
        let vc = SettingsViewController()
        vc.onClose = { [weak self] in
            self?.nav.popViewController(animated: true)
            self?.onFinish?()
        }
        nav.pushViewController(vc, animated: true)
    }
}
