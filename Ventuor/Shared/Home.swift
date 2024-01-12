//
//  Home.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/8/24.
//
// https://www.youtube.com/watch?v=TJfI3-qdta8

import SwiftUI

struct Home: View {
    @State private var tabSelection = 1
    @Binding var selectedTab: String
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Color("TabBackground")
                .ignoresSafeArea()
            
            // Custom tab bar
            CustomTabBar(selectedTab: $selectedTab, tabSelection: $tabSelection)
        })
    }
}

#Preview {
    Home(selectedTab: .constant("house"))
}
