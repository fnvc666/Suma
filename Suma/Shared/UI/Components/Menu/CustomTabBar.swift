//
//  Untitled.swift
//  Suma
//
//  Created by Pavel Pavel on 31/08/2025.
//
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    var items: [TabItem]
    
    var body: some View {
        HStack {
            ForEach(items, id: \.self) { item in
                TabButton(tab: item.tab, icon: item.icon, title: item.title)
            }
        }
        .padding(6)
        .background(.white.opacity(0.8))
        .clipShape(Capsule())
    }
    
    private func TabButton(tab: Tab, icon: String, title: String) -> some View {
        Button {
            selectedTab = tab
        } label: {
            HStack(spacing: 10) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 19)
                    .foregroundStyle(Color(red: 0.19, green: 0.2, blue: 0.2))
                
                if selectedTab == tab {
                    Text(title)
                        .font(.custom("Geist", size: 13)
                            .weight(.medium)
                        )
                        .foregroundStyle(Color(red: 0.19, green: 0.2, blue: 0.2))
                }
            }
        }
        .padding(16)
        .background(selectedTab == tab ? Color(red: 0.95, green: 1, blue: 0.35) : .clear)
        .clipShape(Capsule())
    }
}
