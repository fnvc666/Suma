//
//  Untitled.swift
//  Suma
//
//  Created by Pavel Pavel on 31/08/2025.
//
struct TabItem: Hashable {
    var tab: Tab
    var title: String
    var icon: String
}
enum Tab: Int {
    case home = 0
    case finance = 1
    case savings = 2
}



