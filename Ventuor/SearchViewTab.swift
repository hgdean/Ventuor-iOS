//
//  SearchViewTab.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/9/24.
//

import SwiftUI

struct SearchViewTab: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    @ObservedObject var searchViewModel: SearchViewModel = SearchViewModel()

    @State var searchText: String = ""

    var body: some View {
        NavigationStack() {
            VStack() {
                NavigationStack() {
                    SearchBarView(searchText: $searchViewModel.searchTerm)
                        .onSubmit {
                            searchViewModel.getVentuorListData()
                        }
                }
                .navigationDestination(isPresented: $searchViewModel.searchResult, destination: {
                    VentuorDetailListView(title: "Search Result", ventuors: $searchViewModel.ventuors, displayStatusMessage: $searchViewModel.displayStatusMessage)
                })
            }
        }
    }
}

#Preview {
    SearchViewTab(searchViewModel: SearchViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
