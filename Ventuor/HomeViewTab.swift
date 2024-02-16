//
//  HomeViewTab.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/9/24.
//

import MapKit
import SwiftUI

struct HomeViewTab: View {
    @Binding var tabSelection: Int
    @Binding var activeTab: Tab

    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    @StateObject var manager = LocationDataManager()
    
    var body: some View {
        NavigationStack() {
            VStack() {
                Map(coordinateRegion: $manager.region, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 200)
                
                ScrollView() {
                    VentuorNearby(homeViewModel: homeViewModel)
                    
                    VentuorSearchItem(tabSelection: $tabSelection, activeTab: $activeTab)
                    
                    VentuorAdministration(homeViewModel: homeViewModel)
                    
                    VentuorRecentItems(homeViewModel: homeViewModel)
                    
                    VentuorRecentSearches()
                    
                    VentuorSavedItems(homeViewModel: homeViewModel)
                    
                    VentuorFollowingItems(homeViewModel: homeViewModel)
                }
            }
        }
    }
}

#Preview {
    HomeViewTab(tabSelection: .constant(4), activeTab: .constant(Tab.home))
}
