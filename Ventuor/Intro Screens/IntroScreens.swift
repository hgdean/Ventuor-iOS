//
//  IntroScreens.swift
//  Ventuor
//
//  Created by H Sam Dean on 12/29/23.
//

// https://www.youtube.com/watch?v=QKol0WQpoOs

import SwiftUI
// import Lottie

struct IntroScreens: View {
    @Binding var showIntroScreens: Bool
    private let dotAppearance = UIPageControl.appearance()

    @State var introItems: [IntroItem] = [
        .init(title: "Publishing System",
             subTitle: "Promote, Broadcast, and Showcase Your Places' Activities, Status, and Pertinent Information. The On-The-Go App For Everyone & Every Place. Mobile Publishing System for Place Owners and Managers. Common & Consistent User Interface",
              buttonText: "Next",
              imageUrl: "intro-image-1"
              // lottieView: .init(name: "Animation - 1703964330877", bundle: .main)
             ),
        .init(title: "Digital Business Card",
             subTitle: "Think of it as your mobile business card that is always up-to-date and in everyone's pocket. Make it easy for your visitors to look you up and reach you.",
              buttonText: "Next",
              imageUrl: "intro-image-2"
              // lottieView: .init(name: "Animation - 1703260081956", bundle: .main)
             ),
        .init(title: "Everything Location Guide",
             subTitle: "The Ventuor system is designed to be the all-in-one solution for all location based activities. A portal for your digital presence.",
              buttonText: "Login",
              imageUrl: "intro-image-5"
              // lottieView: .init(name: "Animation - 1703259689848-1", bundle: .main)
             ),
    ]
    
    @State var currentIndex: Int = 0

    var body: some View {
        GeometryReader {
            let size = $0.size
            
            HStack(spacing: 0) {
                ForEach($introItems) { $item in
                    let isLastSlide = (currentIndex == introItems.count - 1)
                    VStack {
                        // Mark: Top Navigator Bar
                        HStack {
                            Button("Back") {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)

                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                            
                            Button("Skip") {
                                currentIndex = introItems.count - 1
                            }
                            .opacity(isLastSlide ? 0 : 1)
                        }
                        .animation(.easeInOut, value: currentIndex)
                        .tint(Color.ventuorBlue)
                        .fontWeight(.bold)
                        
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            
                            Image("\(item.imageUrl)")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .cornerRadius(30)
                                .background(.gray.opacity(0.10))
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                                .frame(height: size.width)
                                                        
                            Text(item.title)
                                .foregroundColor(Color("ventuor-blue"))
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)

                            Text(item.subTitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }
                        
                        Spacer(minLength: 0)
                        
                        // Mark: Next / Login Button
                        VStack(spacing: 15) {
                            Text(isLastSlide ? "Get Started" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, isLastSlide ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background() {
                                    Capsule().fill(Color("ventuor-blue"))
                                }
                                .padding(.horizontal, isLastSlide ? 30 : 100)
                                .onTapGesture {
                                    // Mark: Updating to next index
                                    if currentIndex < introItems.count - 1 {
                                        currentIndex += 1
                                    }
                                    else {
                                        showIntroScreens.toggle()
                                    }
                                }
                            
                            HStack {
                                Text("Terms of Service")
                                Text("Privacy Policy")
                            }
                            .font(.caption2)
                            .underline(true, color: .primary)
                            .offset(y: 5)
                        }
                        
                        
                    }
                    .animation(.easeInOut, value: isLastSlide)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(introItems.count), alignment: .leading)
        }
    }
        
    // Mark: Retreiving Index of the item in the array
    func indexOf(_ item: IntroItem) -> Int {
        if let index = introItems.firstIndex(of: item) {
            return index
        }
        return 0
    }
}

#Preview {
    IntroScreens(showIntroScreens: .constant(false))
}

