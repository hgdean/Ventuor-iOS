//
//  Home.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/8/24.
//
// https://www.youtube.com/watch?v=TJfI3-qdta8

import SwiftUI

struct MainTabView3: View {
    @EnvironmentObject var auth: Auth
    @State var showIntroScreens: Bool

    init(showIntroScreens: Bool) {
        self._showIntroScreens = State(initialValue: Bool(showIntroScreens))
    }

    @State private var tabSelection = 1
    @State private var activeTab: Tab = .home
    @Namespace private var animation
    
    var body: some View {
        VStack() {
            ZStack {
                if !Auth.shared.loggedIn {
                    VStack(spacing: 0) {
                        LandingView()
                            .fullScreenCover(isPresented: $showIntroScreens, content: {
                                IntroScreens(showIntroScreens: $showIntroScreens)
                            })
                    }
                } else {
                    TabView(selection: $tabSelection) {
                        HomeViewTab(tabSelection: $tabSelection, activeTab: $activeTab)
                            .tag(1)
                        // Hiding Native Tab Bar
                            .toolbar(.hidden, for: .tabBar)
                        ProfileViewTab()
                            .tag(2)
                        // Hiding Native Tab Bar
                            .toolbar(.hidden, for: .tabBar)
                        SettingsViewTab()
                            .tag(3)
                        // Hiding Native Tab Bar
                            .toolbar(.hidden, for: .tabBar)
                        SearchViewTab()
                            .tag(4)
                        // Hiding Native Tab Bar
                            .toolbar(.hidden, for: .tabBar)
                        
                    }
                }
            }
            // Custom tab bar
            CustomTabBar2()
        }
    }
    
    let tabBarItems: [(image: String, title: String, counter: Int)] = [
        ("house", "Home", 1),
        ("person", "Profile", 2),
        ("gearshape", "Settings", 3),
        ("magnifyingglass.circle", "Search", 4),
    ]
    
    // Storing each tab midpoints to animate it in future
    @State var tabPoints : [CGFloat] = []
    
    @ViewBuilder
    func CustomTabBar2(_ tint: Color = Color(.ventuorBlue), _ inactiveTint: Color = .ventuorBlue) -> some View {
        HStack(spacing: 0) {
            
            // Tab bar buttons...
            ForEach(0..<4) { index in
                TabBarButton2(image: tabBarItems[index].image, counter: tabBarItems[index].counter, tabSelection: $tabSelection, tabPoints: $tabPoints)
            }
        }
        .padding()
        .background(
            Color.ventuorBlue
                .clipShape(TabCurve(tabPoint: getCurvePoint2() - 15))
        )
        .overlay(
            Circle()
                .fill(Color.ventuorBlue)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint2() - 20)
            , alignment: .bottomLeading
        )
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.bottom, -13)
        
    }
    
    // extracting point
    func getCurvePoint2() -> CGFloat {
        // if tabpoint is empty
        if tabPoints.isEmpty {
            return 10
        } else {
            switch tabSelection {
            case 1:
                return tabPoints[0]
            case 2:
                return tabPoints[1]
            case 3:
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
}

#Preview {
    MainTabView3(showIntroScreens: true)
        .environmentObject(UserProfileModel.shared)
}
