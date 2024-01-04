//
//  OnBoardingItem.swift
//  Ventuor
//
//  Created by H Sam Dean on 12/21/23.
//

// https://www.youtube.com/watch?v=QKol0WQpoOs

import SwiftUI
// import Lottie

struct IntroItem: Identifiable, Equatable {
    static func == (lhs: IntroItem, rhs: IntroItem) -> Bool {
        return true
    }
    
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var buttonText: String
//    var lottieView: LottieAnimationView = .init()
}
