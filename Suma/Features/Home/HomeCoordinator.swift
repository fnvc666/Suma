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
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        vc.title = "Home"
        nav.setViewControllers([vc], animated: false)
    }
}
