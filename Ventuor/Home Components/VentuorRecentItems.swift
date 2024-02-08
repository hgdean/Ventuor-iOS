//
//  VentuorRecentItems.swift
//  Ventuor
//
//  Created by Sam Dean on 1/20/24.
//

import SwiftUI

struct VentuorRecentItems: View {
    @State private var goodToAdvance: Bool = false
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        NavigationStack() {
            Button(action: {
                goodToAdvance = true
                // homeViewModel.getUsersRecentVentuors()
            }, label: {
                HStack(spacing: 20) {
                    Text("RECENT VENTUORS")
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
            VentuorRecentListView(title: "My Recent Ventuors", homeViewModel: homeViewModel)
            //VentuorRecentListView2(title: "My Recent Ventuors", recentVentuors: homeViewModel.recentVentuors, homeViewModel: homeViewModel)
        })
    }
}


#Preview {
    VentuorRecentItems(homeViewModel: HomeViewModel.sample)
}
