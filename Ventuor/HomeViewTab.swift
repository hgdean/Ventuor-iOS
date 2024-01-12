//
//  HomeViewTab.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/9/24.
//

import SwiftUI

struct HomeViewTab: View {
    
    var body: some View {
        NavigationView() {
            VStack() {
                VentuorView()
            }
        }
        .navigationTitle("Riker")
//        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
//        }
//        .padding(0)
    }
}

#Preview {
    HomeViewTab()
}
