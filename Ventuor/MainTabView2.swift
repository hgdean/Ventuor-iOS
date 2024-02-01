//
//  HomeScreen.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI

struct MainTabView2: View {
    @State private var tabSelection = 1
    @State private var activeTab : Tab = .home

    var body: some View {
        TabView(selection: $tabSelection) {
            HomeViewTab(tabSelection: $tabSelection, activeTab: $activeTab).tag(1)
                .toolbar(.hidden, for: .tabBar)
            ProfileViewTab().tag(2)
                .toolbar(.hidden, for: .tabBar)
            SettingsViewTab().tag(3)
                .toolbar(.hidden, for: .tabBar)
            SearchViewTab().tag(4)
                .toolbar(.hidden, for: .tabBar)
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(tabSelection: $tabSelection)
        }
    }
}

#Preview {
    MainTabView2()
}
