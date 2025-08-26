//
//  TabBarCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//
import UIKit

final class TabBarCoordinator: Coordinator {
    var children: [any Coordinator] = []
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
        
        let homeVC = UIViewController(); homeVC.view.backgroundColor = .red;
        let finVC = UIViewController(); finVC.view.backgroundColor = .blue;
        let savVC = UIViewController(); savVC.view.backgroundColor = .green;
        
        homeNav.setViewControllers([homeVC], animated: false)
        finNav.setViewControllers([finVC], animated: false)
        savNav.setViewControllers([savVC], animated: false)
        
        homeNav.tabBarItem = .init(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        finNav.tabBarItem = .init(title: "Finances", image: UIImage(systemName: "barometer"), tag: 1)
        savVC.tabBarItem = .init(title: "Savings", image: UIImage(systemName: "wallet"), tag: 2)
        
        root.setViewControllers([homeNav, finNav, savNav], animated: false)
    }
    
    
}
