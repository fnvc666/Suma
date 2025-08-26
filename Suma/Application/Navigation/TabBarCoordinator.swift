//
//  TabBarCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//
import UIKit

final class TabBarCoordinator: Coordinator {
    var children: [Coordinator] = []
    private let container: AppContainer
    
    let root = UITabBarController()
    
    init(container: AppContainer) {
        self.container = container
    }
    
    func start() {
    // TODO: change to coordinators
        let homeNav = UINavigationController()
        let finNav = UINavigationController()
        let savNav = UINavigationController()
        
        let home = HomeCoordinator(container: container, nav: homeNav)
        let fin = FinanceCoordinator(container: container, nav: finNav)
        let sav = SavingsCoordinator(container: container, nav: savNav)
        
        children = [home, fin, sav]
        children.forEach { $0.start() }
        
        homeNav.tabBarItem = .init(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        finNav.tabBarItem = .init(title: "Finances", image: UIImage(systemName: "barometer"), tag: 1)
        savNav.tabBarItem = .init(title: "Savings", image: UIImage(systemName: "wallet"), tag: 2)
        
        root.setViewControllers([homeNav, finNav, savNav], animated: false)
    }
    
    
}
