//
//  TabSelectionBridge.swift
//  Suma
//
//  Created by Pavel Pavel on 02/09/2025.
//
import Combine

final class TabSelectionBridge: ObservableObject {
    @Published var selected: Tab = .home
}

