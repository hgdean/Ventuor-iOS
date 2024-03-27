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
    @ObservedObject var searchViewModel: SearchViewModel = SearchViewModel()
    //@ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()
    @StateObject var manager = LocationDataManager()

    @State var showSearchSheet: Bool = false
    @State var searchTerm: String = ""
    
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
                
                Spacer()
                
                VStack() {
                    Button(action: {
                        showSearchSheet = true
                    }, label: {
                        Circle()
                            .fill(Color(.ventuorOrange))
                            .frame(height: 60)
                            .overlay(content: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)
                            })
                            .shadow(color: Color.black.opacity(0.7), radius: 5, x: 5, y:4)
                    })
                    .sheet(isPresented: $showSearchSheet,
                           onDismiss: {
                        showSearchSheet = false
                    }) {
                        VStack(alignment: .leading, spacing: 18) {
                            SearchBarView(searchText: $searchTerm)
                                .onSubmit {
                                    doOnSubmitSearch(term: searchTerm)
                                }
                                .padding(.horizontal, 20)
                                .presentationDragIndicator(.visible)
                            
                            ScrollView() {
                                RecentSearchTextView(
                                    listSearchTerms: userProfileModel.userRecentSearchTerms.getUserSearchItem(userKey: Auth.shared.getUserKey()!),
                                        showSearchSheet: $showSearchSheet, searchTerm: $searchTerm, searchViewModel: searchViewModel)
                                    .padding(.horizontal, 20)

                                SearchCategoryView(showSearchSheet: $showSearchSheet, searchTerm: $searchTerm, searchViewModel: searchViewModel)
                                    .padding(.top, 25)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .padding(.top, 30)
                        .background(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .presentationDetents([.fraction(0.99)])
                        .presentationCornerRadius(25)
                        .presentationBackground(.regularMaterial)
                        .presentationBackgroundInteraction(.disabled)
                    }
                }
                .padding(.bottom, 69)
                .navigationDestination(isPresented: $searchViewModel.searchResult, destination: {
                    VentuorDetailListView(liveMode: true, ventuorViewModel: VentuorViewModel(liveMode: true), title: "Search Result", ventuors: $searchViewModel.ventuors, displayStatusMessage: $searchViewModel.displayStatusMessage)
                })
            }
            .background(.white)
        }
        .errorAlert(error: $searchViewModel.errorSearchResult)
        .onAppear() {
            homeViewModel.getYouAreHereVentuorList()
        }
    }
    
    func doOnSubmitSearch(term: String) {
        showSearchSheet = false
        addToRecentSearchTerms(term: term)
        searchViewModel.searchTerm = term
        
        searchViewModel.getVentuorListData()
    }
    
    func addToRecentSearchTerms(term: String) {
        userProfileModel.addToRecentSearchTerms(cacheSearchItem: SearchItem(userKey: Auth.shared.getUserKey()!, term: term))
    }

}

#Preview {
    HomeViewTab(tabSelection: .constant(4), activeTab: .constant(Tab.home), homeViewModel: HomeViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
