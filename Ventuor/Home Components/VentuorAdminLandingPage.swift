//
//  VentuorAdminMyTestItems.swift
//  Ventuor
//
//  Created by Sam Dean on 1/20/24.
//

import SwiftUI

struct VentuorAdminLandingPage: View {
    @State var title: String = ""
    @State private var goodToAdvance: Bool = false
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    //@ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()

    @State var liveMode: Bool = true
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 25) {
                Button(action: {
                    goodToAdvance = true
                    title = "Test Ventuors"
                    liveMode = false
                    homeViewModel.getAdminVentuorListInTest()
                }, label: {
                    HStack(spacing: 20) {
                        Text("My Test Ventuors")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "chevron.right.circle")
                            .resizable()
                            .scaledToFit()
                            .padding([.top, .bottom], 20)
                            .foregroundColor(.ventuorBlue)
                            .opacity(0.3)
                            .frame(width: 20)
                    }
                    .padding([.leading, .trailing], 15)
                    //.border(width: 1, edges: [.bottom], color: .ventuorGray)
                })
                
                Button(action: {
                    goodToAdvance = true
                    title = "Live Ventuors"
                    liveMode = true
                    homeViewModel.getAdminVentuorListInLive()
                }, label: {
                    HStack(spacing: 20) {
                        Text("My Live Ventuors")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "chevron.right.circle")
                            .resizable()
                            .scaledToFit()
                            .padding([.top, .bottom], 20)
                            .foregroundColor(.ventuorBlue)
                            .opacity(0.3)
                            .frame(width: 20)
                    }
                    .padding([.leading, .trailing], 15)
                    //.border(width: 1, edges: [.bottom], color: .ventuorGray)
                })
                
                Spacer()
            }
            .background(Color.ventuorBackgroundSplash)
            .padding(.top, 20)
        }
        .navigationDestination(isPresented: $goodToAdvance, destination: {
            VentuorDetailListView(liveMode: liveMode, ventuorViewModel: VentuorViewModel(liveMode: liveMode), title: title, ventuors: $homeViewModel.ventuors, displayStatusMessage: $homeViewModel.displayStatusMessage)
                .background(Color.ventuorBackgroundSplash)
        })
        .navigationTitle("Administration")
        .foregroundColor(.ventuorBlue)
        .background(Color.ventuorBackgroundSplash)
    }
}

#Preview {
    VentuorAdminLandingPage(homeViewModel: HomeViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
