//
//  SplashView.swift
//  Ventuor
//
//  Created by H Sam Dean on 12/29/23.
//

import SwiftUI

struct SplashView: View {
    @Binding var isSplashScreenActive: Bool

    var body: some View {
        VStack(spacing: 0) {
            Image("1000x1000 @ 300 res")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Image("text-ventuor-word-1")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.white)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.isSplashScreenActive = false
                }
            }
        }
    }
}

#Preview {
    SplashView(isSplashScreenActive: .constant(true))
}
