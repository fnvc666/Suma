//
//  SettingsViewController.swift
//  Suma
//
//  Created by Pavel Pavel on 27/08/2025.
//

import UIKit

final class SettingsViewController: UIViewController {
    var onClose: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(closeTapped)
        )
    }
    
    @objc private func closeTapped() { onClose?() }
}
