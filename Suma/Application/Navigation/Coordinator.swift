//
//  Coordinator.swift
//  Suma
//
//  Created by Pavel Pavel on 26/08/2025.
//

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    func start()
}
