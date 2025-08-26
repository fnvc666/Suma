//
//  OnboardingCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//
import UIKit

final class OnboardingCoordinator: Coordinator {
    var children: [Coordinator] = []
    private let container: AppContainer
    let root: UIViewController
    
    init(container: AppContainer) {
        self.container = container
        self.root = UIViewController()
        root.view.backgroundColor = .blue
        root.title = "Onboarding"
    }
    
    func start() {
        //
    }
    
    
}
