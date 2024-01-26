//
//  VentuorNearby.swift
//  Ventuor
//
//  Created by Sam Dean on 1/18/24.
//

import SwiftUI

struct VentuorNearby: View {
    @State private var goodToAdvance: Bool = false
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack() {
            Button(action: {
                goodToAdvance = true
                homeViewModel.getVentuorNearbyList()
            }, label: {
                HStack(spacing: 20) {
                    Text("Nearby")
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
                .border(width: 1, edges: [.bottom], color: .ventuorGray)
            })
        }
        .navigationDestination(isPresented: $goodToAdvance, destination: {
            VentuorListView(title: "What's Nearby", homeViewModel: homeViewModel)
        })
    }
}

#Preview {
    VentuorNearby(homeViewModel: HomeViewModel.sample)
}
