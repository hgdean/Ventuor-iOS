//
//  CustomTabBar2.swift
//  Ventuor
//
//  Created by Sam Dean on 1/24/24.
//

import SwiftUI

struct MainTabView: View {
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
            .overlay(alignment: .bottom, content: {
                AnotherCustomTabBar()
            })
    }
    
    @ViewBuilder
    func AnotherCustomTabBar(_ tint: Color = Color(.ventuorBlue), _ inactiveTint: Color = .ventuorBlue) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem2(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab
                    )
                    
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(content: {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem2: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 50 : 35, height: activeTab == tab ? 50 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .contentShape(Rectangle())
        .onTapGesture {
            activeTab = tab
        }
        .padding(.bottom, -25)
    }
}

#Preview {
    MainTabView()
        .environmentObject(UserProfileModel.shared)
}
