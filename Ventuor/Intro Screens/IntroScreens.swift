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
              buttonText: "Next"
              // lottieView: .init(name: "Animation - 1703964330877", bundle: .main)
             ),
        .init(title: "Digital Business Card",
             subTitle: "Think of it as your mobile business card that is always up-to-date and in everyone's pocket. Make it easy for your visitors to look you up and reach you.",
              buttonText: "Next"
              // lottieView: .init(name: "Animation - 1703260081956", bundle: .main)
             ),
        .init(title: "Everything Location Guide",
             subTitle: "The Ventuor system is designed to be the all-in-one solution for all location based activities. A portal for your digital presence.",
              buttonText: "Login"
              // lottieView: .init(name: "Animation - 1703259689848-1", bundle: .main)
             ),
    ]
    
    // Mark: Current Slide Index
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
                                    playAnimation()
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            //.foregroundColor(Color("ventuor-blue"))

                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                            
                            Button("Skip") {
                                currentIndex = introItems.count - 1
                                playAnimation()
                            }
                            .opacity(isLastSlide ? 0 : 1)
                        }
                        .animation(.easeInOut, value: currentIndex)
                        .tint(Color.ventuorBlue)
                        .fontWeight(.bold)
                        
                        // Mark: Movable Slides
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            
                            // Mark: Resizable LottieView
                            ResizableLottieView(introItem: $item)
                                .frame(height: size.width)
                                .onAppear {
                                    // Mark: Initially playing first slide of animation
                                    if currentIndex == indexOf(item) {
//                                        item.lottieView.play(toProgress: 0.7)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            
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
                                        // Mark: Pausing previous animiation
//                                        let currentProgress = introItems[currentIndex].lottieView.currentProgress
//                                        introItems[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                        currentIndex += 1
                                        // Mark: Play next animation from start
                                        playAnimation()
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
    
    func playAnimation() {
//        introItems[currentIndex].lottieView.currentProgress = 0
//        introItems[currentIndex].lottieView.play(toProgress: 0.9)
    }
    
    // Mark: Retreiving Index of the item in the array
    func indexOf(_ item: IntroItem) -> Int {
        if let index = introItems.firstIndex(of: item) {
            return index
        }
        return 0
    }
}

// Mark: Resizable Lottie View without Backgroun
struct ResizableLottieView: UIViewRepresentable {
    @Binding var introItem: IntroItem
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView) {
//        let lottieView = introItem.lottieView
//        lottieView.backgroundColor = .clear
//        lottieView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Mark: Applying constraints
//        let constraints = [
//            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
//            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor),
//        ]
//        to.addSubview(lottieView)
//        to.addConstraints(constraints)
    }
}

#Preview {
    IntroScreens(showIntroScreens: .constant(false))
}

