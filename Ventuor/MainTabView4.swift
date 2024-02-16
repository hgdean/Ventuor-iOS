//
//  CustomTabBar2.swift
//  Ventuor
//
//  Created by Sam Dean on 1/24/24.
//

import SwiftUI

struct MainTabView4: View {
    @EnvironmentObject var userProfileModel: UserProfileModel
    @State private var tabSelection = 1
    @State private var activeTab: Tab = .home

    @Namespace private var animation
    var body: some View {
            TabView(selection: $activeTab) {
                HomeViewTab(tabSelection: $tabSelection, activeTab: $activeTab)
                    .tag(Tab.home)
                    // Hiding Native Tab Bar
                    .toolbar(.hidden, for: .tabBar)
                ProfileViewTab()
                    .tag(Tab.profile)
                    // Hiding Native Tab Bar
                    .toolbar(.hidden, for: .tabBar)
                SettingsViewTab()
                    .tag(Tab.settings)
                    // Hiding Native Tab Bar
                    .toolbar(.hidden, for: .tabBar)
                SearchViewTab()
                    .tag(Tab.search)
                    // Hiding Native Tab Bar
                    .toolbar(.hidden, for: .tabBar)
            }
            .overlay(alignment: .bottom) {
                TabBarView(activeTab: $activeTab)
                    .offset(y: 20)
            }
    }
}

#Preview {
    MainTabView4()
        .environmentObject(UserProfileModel.shared)
}
