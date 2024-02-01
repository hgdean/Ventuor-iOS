//
//  CircleAnimation.swift
//  PhotoGalleryApp
//
//  Created by Sam Dean on 1/30/24.
//

import SwiftUI

struct CircleAnimation: View {
    @Binding var circleA: CGFloat
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    circleA = circleA == 0.0 ? 0.5 : 0.0
                }
            } label: {
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: circleA)
                        .stroke(lineWidth: 4)
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(-90))
                    Circle()
                        .frame(width: 4, height: 4)
                        .offset(y: -20)
                }
            }
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    circleA = circleA == 0.0 ? 0.5 : 0.0
                }
            } label: {
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: circleA)
                        .stroke(lineWidth: 4)
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(90))
                    Circle()
                        .frame(width: 4, height: 4)
                        .offset(y: 20)
                }
            }
            .offset(y: -48)
        }
        .foregroundColor(.black)
    }
}

#Preview {
    CircleAnimation(circleA: .constant(0.5))
}
