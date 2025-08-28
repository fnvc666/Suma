//
//  CategoryCoordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//
import UIKit

final class CategoryCoordinator: Coordinator {
    var children: [Coordinator] = []
    private let container: AppContainer
    private let nav: UINavigationController
    private let categoryId: UUID
    
    var onFinish: (() -> Void)?
    
    init(container: AppContainer, nav: UINavigationController, categoryId: UUID) {
        self.container = container
        self.nav = nav
        self.categoryId = categoryId
    }
    
    func start() {
        //
    }
}
