//
//  RootScreen.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI

struct RootScreen: View {
    @EnvironmentObject var auth: Auth
    @State var showIntroScreens: Bool
    @AppStorage("shouldShowIntroScreens") var shouldShowIntroScreens: Bool = true
    
    var body: some View {
        VStack() {
//            if !shouldShowIntroScreens {
                if Auth.shared.loggedIn {
                    //MainTabView()
                    // MainTabView2()
                    // MainTabView3(showIntroScreens: false)
                    MainTabView4()
                } else {
                    LandingView()
                }
//            }
        }
        .fullScreenCover(isPresented: $shouldShowIntroScreens, content: {
            IntroScreens(showIntroScreens: $shouldShowIntroScreens)
        })
    }
}

#Preview {
    RootScreen(showIntroScreens: true)
}

