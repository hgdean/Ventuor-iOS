//
//  ContentView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI

struct ContentView: View {

    @State var isSplashScreenActive: Bool = true

    var body: some View {
        if self.isSplashScreenActive {
            SplashView(isSplashScreenActive: $isSplashScreenActive)
        } else {
            RootScreen(showIntroScreens: !Auth.shared.loggedIn)
                .environmentObject(Auth.shared)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserProfileModel.shared)
}
