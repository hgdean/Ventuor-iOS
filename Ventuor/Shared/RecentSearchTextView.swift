//
//  RecentSearchTextView.swift
//  Ventuor
//
//  Created by Sam Dean on 3/21/24.
//

import SwiftUI

struct RecentSearchTextView: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    var listSearchTerms: CacheSearchTerms
    @Binding var showSearchSheet: Bool
    @Binding var searchTerm: String

    @ObservedObject var searchViewModel: SearchViewModel

    var body: some View {
        let listCount = listSearchTerms.item.count
            VStack(alignment: .leading) {
                Text("Recent searches")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.ventuorBlue)
                
                if listCount == 0 {
                    ContentUnavailableView(label: {
                    }, description: {
                        VStack() {
                            Image(systemName: "tray.fill")
                            Text("Nothing to show")
                        }
                        .foregroundColor(Color.gray)
                    }, actions: {
                    })
                    .frame(height: 50)
                } else {
                ScrollView(.horizontal) {
                    //LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 50)), count: 1), spacing: 4) {
                    LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 5, maximum: 5)), count: 1), spacing: 7) {
                        ForEach(0..<listCount, id: \.self) { index in
                            ShowSearchItem(term: listSearchTerms.item[index].term)
                        }
                    }
                    .frame(height: 30)
                }
                //.padding(.leading, 17)
                //.background(Color.black)
                //.scrollPosition(id: $selectedTab)
                .scrollIndicators(.hidden)
                //.scrollTargetBehavior(.paging)
                .scrollClipDisabled()
            }
        }
    }
    
    func doOnSubmitSearchFromRecentSearchesButton(term: String) {
        showSearchSheet = false
        addToRecentSearchTerms(term: term)
        searchViewModel.searchTerm = term
        searchTerm = term
        
        searchViewModel.getVentuorListData()
        // homeViewModel.getAdminVentuorListInLive()
        // homeViewModel.getVentuorNearbyList()
    }

    func addToRecentSearchTerms(term: String) {
        userProfileModel.addToRecentSearchTerms(cacheSearchItem: SearchItem(userKey: Auth.shared.getUserKey()!, term: term))
    }

    @ViewBuilder
    func ShowSearchItem(term: String) -> some View {
        Button(action: {
            doOnSubmitSearchFromRecentSearchesButton(term: term)
        }, label: {
            ZStack() {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.ventuorLightGray))
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(term)
                            .font(.callout)
                            .fontWeight(.regular)
                            .lineLimit(1)
                            .foregroundColor(.ventuorBlue)
                    }
                }
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 5)
                .frame(maxWidth: 200)
                .frame(minWidth: 0)
            }
        })
    }

}

//#Preview {
//    RecentSearchTextView()
//}
