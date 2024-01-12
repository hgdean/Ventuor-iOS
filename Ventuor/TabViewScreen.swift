//
//  HomeScreen.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI

struct TabViewScreen: View {
    @State private var tabSelection = 1
    @State var selectedTab: String = "house"
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeViewTab().tag(1)
            ProfileViewTab().tag(2)
            SettingsViewTab().tag(3)
            SearchViewTab().tag(4)
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(selectedTab: $selectedTab, tabSelection: $tabSelection)
                .background()
                .opacity(1)
        }
    }
}

#Preview {
    TabViewScreen()
}
