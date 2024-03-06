//
//  RootScreen.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI
import SwiftData

struct RootScreen: View {
    @EnvironmentObject var auth: Auth // Can only be used in a View
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View
    
    @State var showIntroScreens: Bool
    @AppStorage("shouldShowIntroScreens") var shouldShowIntroScreens: Bool = true

    init(showIntroScreens: Bool) {
        self.showIntroScreens = showIntroScreens
    }
    var body: some View {

        VStack() {
            if auth.loggedIn {
                // MainTabView()
                // MainTabView2()
                // MainTabView3(showIntroScreens: false)
                MainTabView4()
                    .onAppear() {
                        userProfileModel.loadUserProfile(cb: cbGetUserProfile)
                    }
            } else {
                LandingView()
            }
        }
        .fullScreenCover(isPresented: $shouldShowIntroScreens, content: {
            IntroScreens(showIntroScreens: $shouldShowIntroScreens)
        })
    }
    
    fileprivate func cbGetUserProfile(data: Data?, error: NSError?) -> Void {
    }
}

#Preview {
    RootScreen(showIntroScreens: true)
        .environmentObject(Auth.shared)
        .environmentObject(UserProfileModel.shared)
}

