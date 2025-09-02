//
//  TabBarCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//
import UIKit

final class TabBarCoordinator: NSObject, Coordinator, UITabBarControllerDelegate {
    var children: [Coordinator] = []
    private let container: AppContainer
    let root = RootTabViewController()
    
    init(container: AppContainer) { self.container = container }
    
    func start() {
        let homeNav = UINavigationController()
        let finNav = UINavigationController()
        let savNav = UINavigationController()
        
        let home = HomeCoordinator(container: container, nav: homeNav)
        let fin = FinanceCoordinator(container: container, nav: finNav)
        let sav = SavingsCoordinator(container: container, nav: savNav)
        
        children = [home, fin, sav]
        children.forEach { $0.start() }
        
        root.setViewControllers([homeNav, finNav, savNav], animated: false)
        
        let items: [TabItem] = [
            .init(tab: .home, title: "Home", icon: "homeIcon"),
            .init(tab: .finance, title: "Finance", icon: "dollarIcon"),
            .init(tab: .savings, title: "Savings", icon: "piggyIcon"),
        ]
        root.installTabBar(items: items)
        
//        root.onTabChange = { [weak self] tab in
//            guard let self else { return }
//            switch tab {
//                case .home:    break
//                case .finance: break
//                case .savings: break
//            }
//        }
    }
    
    func select(tab: Tab) {
        root.select(tab: tab)
        if let nav = root.viewControllers?[tab.rawValue] as? UINavigationController {
                    nav.popToRootViewController(animated: false)
        }
    }
}
