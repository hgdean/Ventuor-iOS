//
//  ContentView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var auth: Auth
    @State var isSplashScreenActive: Bool = true

    init() {
    }
    
    var body: some View {
        if self.isSplashScreenActive {
            SplashView(isSplashScreenActive: $isSplashScreenActive)
        } else {
            RootScreen(showIntroScreens: !auth.loggedIn)
                .environmentObject(Auth.shared)
        }
    }
}

#Preview {
    ContentView()
}
