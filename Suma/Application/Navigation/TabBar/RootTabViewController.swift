//
//  RootTabViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 01/09/2025.
//
import UIKit
import SwiftUI
import Combine

final class RootTabViewController: UITabBarController {
    private var hosting: UIHostingController<TabBarContainer>?
    private let selection = TabSelectionBridge()
    private var bag = Set<AnyCancellable>()
    
    private var currentTab: Tab = .home {
        didSet {
            selectedIndex = currentTab.rawValue
            onTabChange?(currentTab)
        }
    }
    
    var onTabChange: ((Tab) -> Void)?
    
    func installTabBar(items: [TabItem], initial: Tab = .home) {
        currentTab = initial
        tabBar.isHidden = true
        
        // SUI -> UIKit
        selection.$selected
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self else { return }
                if self.currentTab != newValue {
                    self.currentTab = newValue
                }
            }
            .store(in: &bag)
        
        let bar = TabBarContainer(selection: selection, items: items)
        
        let hc = UIHostingController(rootView: bar)
        hosting = hc
        
        addChild(hc)
        view.addSubview(hc.view)
        hc.didMove(toParent: self)
        
        hc.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hc.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hc.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    func select(tab: Tab) {
        guard currentTab != tab else { return }
        currentTab = tab
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame = .zero
    }
}
