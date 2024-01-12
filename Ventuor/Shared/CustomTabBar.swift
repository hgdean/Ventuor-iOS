//
//  CustomTabBar.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/8/24.
//
// https://www.youtube.com/watch?v=TJfI3-qdta8

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    @Binding var tabSelection: Int
    
    let tabBarItems: [(image: String, title: String, counter: Int)] = [
        ("house", "Home", 1),
        ("person", "Profile", 2),
        ("gearshape", "Settings", 3),
        ("magnifyingglass.circle", "Search", 4),
    ]
    
    // Storing each tab midpoints to animate it in future
    @State var tabPoints : [CGFloat] = []
        
    var body: some View {
        HStack(spacing: 0) {
            
            // Tab bar buttons...

//            TabBarButton(image: "house", selectedTab: $selectedTab, tabPoints: $tabPoints)
//            TabBarButton(image: "bookmark", selectedTab: $selectedTab, tabPoints: $tabPoints)
//            TabBarButton(image: "message", selectedTab: $selectedTab, tabPoints: $tabPoints)
//            TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)

            ForEach(0..<4) { index in
                TabBarButton2(image: tabBarItems[index].image, counter: tabBarItems[index].counter, tabSelection: $tabSelection, tabPoints: $tabPoints)
            }
        }
        .padding()
        .background(
            Color.ventuorBlue
                .clipShape(TabCurve(tabPoint: getCurvePoint2() - 15)))
        .overlay(
        
            Circle()
                .fill(Color.ventuorBlue)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint2() - 20)
            , alignment: .bottomLeading
        )
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.bottom, -13)
    }
    
//    // extracting point
//    func getCurvePoint() -> CGFloat {
//        // if tabpoint is empty
//        if tabPoints.isEmpty {
//            return 10
//        } else {
//            switch selectedTab {
//            case "house":
//                return tabPoints[0]
//            case "bookmark":
//                return tabPoints[1]
//            case "message":
//                return tabPoints[2]
//            default:
//                return tabPoints[3]
//            }
//        }
//    }
    
    // extracting point
    func getCurvePoint2() -> CGFloat {
        // if tabpoint is empty
        if tabPoints.isEmpty {
            return 10
        } else {
            switch tabSelection {
            case 1:
                return tabPoints[0]
            case 2:
                return tabPoints[1]
            case 3:
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
}

#Preview {
    Home(selectedTab: .constant("house"))
}

//struct TabBarButton: View {
//    
//    var image: String
//    @Binding var selectedTab: String
//    @Binding var tabPoints: [CGFloat]
//    
//    var body: some View {
//        // For getting mid Point of each button for curve animation
//        GeometryReader { reader -> AnyView in
//            
//            // extracting MidPoint and Storing...
//            let midX = reader.frame(in: .global).midX
//            
//            DispatchQueue.main.async {
//                
//                // avoiding junk data
//                if tabPoints.count <= 4 {
//                    tabPoints.append(midX)
//                }
//            }
//            
//            return AnyView(
//                Button(action: {
//                    // changing tab
//                    // sprint animation
//                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) { selectedTab = image
//                    }
//                }, label: {
//                    
//                    // filling the color if its selected
//                    
//                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
//                        .font(.system(size: 20, weight: .semibold))
//                        .foregroundColor(Color("TabSelected"))
//                        // Lifting view
//                        // if its selected
//                        .offset(y: selectedTab == image ? -10 : 0)
//                })
//                // Max frame
//                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)            
//            )
//        }
//        // Max height
//        .frame(height: 50)
//    }
//}

struct TabBarButton2: View {
    
    var image: String
    var counter: Int
    @Binding var tabSelection: Int
    @Binding var tabPoints: [CGFloat]
        
    var body: some View {
        // For getting mid Point of each button for curve animation
        GeometryReader { reader -> AnyView in
            
            // extracting MidPoint and Storing...
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                
                // avoiding junk data
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button(action: {
                    // changing tab
                    // sprint animation
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) { tabSelection = counter}
                }, label: {
                    
                    // filling the color if its selected
                    
                    Image(systemName: "\(image)\(tabSelection == counter ? ".fill" : "")")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("TabSelected"))
                        // Lifting view
                        // if its selected
                        .offset(y: tabSelection == counter ? -10 : 0)
                })
                // Max frame
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            )
        }
        // Max height
        .frame(height: 34)
    }
}
