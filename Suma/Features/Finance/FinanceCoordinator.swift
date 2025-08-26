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
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        vc.title = "Finance"
        nav.setViewControllers([vc], animated: false)
    }
    
    
}
