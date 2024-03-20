//
//  HomeViewTab.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/9/24.
//

import MapKit
import SwiftUI

struct HomeViewTab: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    @Binding var tabSelection: Int
    @Binding var activeTab: Tab

    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    //@ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()
    @StateObject var manager = LocationDataManager()

    var body: some View {

        NavigationStack() {
            VStack() {
                Map(coordinateRegion: $manager.region, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 200)

                ScrollView() {
                    HorizontalViewList(recentVentuors2: userProfileModel.userRecentVentuors.getUserVentuors(userKey: Auth.shared.getUserKey() ?? ""), homeViewModel: homeViewModel)
                        .onAppear() {
                            homeViewModel.objectWillChange.send()
                        }

                    Divider()
                    
                    if $homeViewModel.isThereSomethingHere.wrappedValue {
                        YouAreHereLink(homeViewModel: homeViewModel)
                    }

                    VentuorNearby()
                }
            }
            .background(.white)
        }
//        .alert(item: $userProfileModel.message) { message in
//            return Alert(
//                title: Text(message.title),
//                message: Text(message.message),
//                dismissButton: .cancel()
//            )
//        }
        .onAppear() {
            homeViewModel.getYouAreHereVentuorList()
        }
    }
}

#Preview {
    HomeViewTab(tabSelection: .constant(4), activeTab: .constant(Tab.home), homeViewModel: HomeViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
