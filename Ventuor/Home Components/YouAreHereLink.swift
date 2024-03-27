//
//  YouAreHereLink.swift
//  Ventuor
//
//  Created by Sam Dean on 3/1/24.
//

import SwiftUI

struct YouAreHereLink: View {
    @State private var goodToAdvance: Bool = false
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel(liveMode: true)

    var body: some View {
        NavigationStack() {
            Button(action: {
                goodToAdvance = true
            }, label: {
                HStack(spacing: 20) {
                    Text("You are here ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.ventuorBlue)
                    
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .scaledToFit()
                        .padding([.top, .bottom], 20)
                        .foregroundColor(.ventuorBlue)
                        .opacity(0.3)
                        .frame(width: 20)
                }
                .padding([.leading, .trailing], 15)
                .border(width: 1, edges: [.bottom], color: .ventuorGray)
            })
        }
        .navigationDestination(isPresented: $goodToAdvance, destination: {
            VentuorDetailListView(liveMode: true, ventuorViewModel: ventuorViewModel, title: "You are here..", ventuors: $homeViewModel.youAreHereVentuorList, displayStatusMessage: .constant("Ready"))
                .background(Color.ventuorBackgroundSplash)
        })
    }
}

#Preview {
    YouAreHereLink(homeViewModel: HomeViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
