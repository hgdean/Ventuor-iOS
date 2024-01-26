//
//  VentuorFollowingItems.swift
//  Ventuor
//
//  Created by Sam Dean on 1/20/24.
//

import SwiftUI

struct VentuorFollowingItems: View {
    @State private var goodToAdvance: Bool = false
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        NavigationStack() {
            Button(action: {
                goodToAdvance = true
                homeViewModel.getUsersFollowingVentuors()
            }, label: {
                HStack(spacing: 20) {
                    Text("FOLLOWING VENTUORS")
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
            VentuorListView(title: "Following", homeViewModel: homeViewModel)
        })
    }}

#Preview {
    VentuorFollowingItems(homeViewModel: HomeViewModel.sample)
}
