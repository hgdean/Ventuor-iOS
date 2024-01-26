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
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 25) {
                Button(action: {
                    goodToAdvance = true
                    title = "Test Ventuors"
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
                    .border(width: 1, edges: [.bottom], color: .ventuorGray)
                })
                
                Button(action: {
                    goodToAdvance = true
                    title = "Live Ventuors"
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
                    .border(width: 1, edges: [.bottom], color: .ventuorGray)
                })
            }
        }
        .navigationDestination(isPresented: $goodToAdvance, destination: {
            VentuorListView(title: title, homeViewModel: homeViewModel)
        })
        .navigationTitle("Administration")
    }
}

#Preview {
    VentuorAdminLandingPage(homeViewModel: HomeViewModel.sample)
}
