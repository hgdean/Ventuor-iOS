//
//  RootScreen.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI

struct RootScreen: View {
    @State var showIntroScreens: Bool

    init(showIntroScreens: Bool) {
        self._showIntroScreens = State(initialValue: Bool(showIntroScreens))
    }
    var body: some View {
        NavigationView() {
            if !showIntroScreens {
                if Auth.shared.loggedIn {
                    HomeScreen()
                } else {
                    LandingView()
                }
            }
        }
        .fullScreenCover(isPresented: $showIntroScreens, content: {
            IntroScreens(showIntroScreens: $showIntroScreens)
        })

    }
}

#Preview {
    RootScreen(showIntroScreens: true)
}
