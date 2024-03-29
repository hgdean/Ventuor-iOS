//
//  CustomTabBar2.swift
//  Ventuor
//
//  Created by Sam Dean on 1/24/24.
//

import SwiftUI

struct MainTabView4: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View
    @State private var tabSelection = 1
    @State private var activeTab: Tab = .home

    @Namespace private var animation
    var body: some View {
            TabView(selection: $activeTab) {
                HomeViewTab(tabSelection: $tabSelection, activeTab: $activeTab)
                    .tag(Tab.home)
                    // Hiding Native Tab Bar
                    .toolbar(.hidden, for: .tabBar)
                    .environmentObject(UserProfileModel.shared)
                ProfileViewTab()
                    .tag(Tab.profile)
                    // Hiding Native Tab Bar
                    .toolbar(.hidden, for: .tabBar)
                ExploreViewTab(activeTab: $activeTab)
                    .tag(Tab.explore)
                    // Hiding Native Tab Bar
                    .toolbar(.hidden, for: .tabBar)
                    .environmentObject(UserProfileModel.shared)
                AdminViewTab(activeTab: $activeTab)
                    .tag(Tab.admin)
                    // Hiding Native Tab Bar
                    .toolbar(.hidden, for: .tabBar)
                    .environmentObject(UserProfileModel.shared)
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
