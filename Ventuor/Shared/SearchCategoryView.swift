//
//  SearchCategoryView.swift
//  Ventuor
//
//  Created by Sam Dean on 3/21/24.
//

import SwiftUI

struct SearchCategoryView: View {
    let rowsFl5: [GridItem] = [GridItem(.flexible())]

    @Binding var showSearchSheet: Bool
    @Binding var searchTerm: String

    @ObservedObject var searchViewModel: SearchViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Search category")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.ventuorBlue)

            ScrollView(.horizontal) {
                LazyHGrid(rows: rowsFl5, spacing: 10) {
                    ForEach(0..<searchCategoryList1.count, id: \.self) { index in
                        ShowSearchCategoryItem(category: searchCategoryListAll1[index])
                            .padding(0)
                    }
                    .padding(0)
                }
                .padding(0)
                .frame(height: 30)
            }
            //.padding(.leading, 17)
            //.scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            //.scrollTargetBehavior(.paging)
            .scrollClipDisabled()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rowsFl5, spacing: 10) {
                        ForEach(0..<searchCategoryList2.count, id: \.self) { index in
                            ShowSearchCategoryItem(category: searchCategoryListAll2[index])
                                .padding(0)
                        }
                        .padding(0)
                    }
                    .padding(0)
                    .frame(height: 30)
                }
            //.padding(.leading, 17)
            //.background(Color.black)
            //.scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            //.scrollTargetBehavior(.paging)
            .scrollClipDisabled()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rowsFl5, spacing: 10) {
                        ForEach(0..<searchCategoryList3.count, id: \.self) { index in
                            ShowSearchCategoryItem(category: searchCategoryListAll3[index])
                                .padding(0)
                        }
                        .padding(0)
                    }
                    .padding(0)
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
    
    func doOnSubmitSearchFromSearcheCategory(term: String) {
        showSearchSheet = false
        searchViewModel.searchTerm = term
        
        searchViewModel.getVentuorListData(category: term)
        // homeViewModel.getAdminVentuorListInLive()
        // homeViewModel.getVentuorNearbyList()
    }
    
    @ViewBuilder
    func ShowSearchCategoryItem(category: Category) -> some View {
        Button(action: {
            doOnSubmitSearchFromSearcheCategory(term: category.title)
        }, label: {
            ZStack() {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(uiColor: UIColor.fromHexString(category.bgColor)))

                    VStack(alignment: .leading, spacing: 0) {
                        Text(category.title)
                            .font(.callout)
                            .fontWeight(.regular)
                            .lineLimit(1)
                            .foregroundColor(.ventuorBlue)
                    }
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 5)
                .frame(minWidth: 0)
            }
        })

    }
}

//#Preview {
//    SearchCategoryView()
//}
