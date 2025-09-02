//
//  TabBarContainer.swift
//  Suma
//
//  Created by Pavel Pavel on 02/09/2025.
//
import SwiftUI

struct TabBarContainer: View {
    @ObservedObject var selection: TabSelectionBridge
    let items: [TabItem]

    var body: some View {
        CustomTabBar(selectedTab: $selection.selected, items: items)
    }
}

