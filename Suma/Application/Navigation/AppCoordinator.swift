//
//  Untitled.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//
import UIKit

final class AppCoordinator: Coordinator {
    var children: [any Coordinator] = []
    private let window: UIWindow
    private let container: AppContainer
    
    init(window: UIWindow, container: AppContainer) {
        self.window = window
        self.container = container
    }
    
    func start() {
        showMainFlow()
    }
    
    private func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(container: container)
        children = [tabBarCoordinator]
        tabBarCoordinator.start()
        
        window.rootViewController = tabBarCoordinator.root
        window.makeKeyAndVisible()
    }
    
    private func showOnboardingFlow() {
        let onboarding = OnboardingCoordinator(container: container)
        children = [onboarding]
        onboarding.start()
        
        window.rootViewController = onboarding.root
        window.makeKeyAndVisible()
    }
}
