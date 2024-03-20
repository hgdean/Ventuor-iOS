//
//  RecentSearchTerms.swift
//  Ventuor
//
//  Created by Sam Dean on 3/17/24.
//

import SwiftUI

//var previewSearchItems0: [SearchItem] = []
//var previewSearchItems: [SearchItem] = [ .init(userKey: "Key1", term: "Testing"), .init(userKey: "Key2", term: "123")]
//var previewCacheSearchTerms: CacheSearchTerms = .init(item: previewSearchItems)

struct RecentSearchTermsView2: View {

    @State var listSearchTerms: CacheSearchTerms
    var body: some View {
        let listCount = listSearchTerms.item.count
        if listCount == 0 {
            ContentUnavailableView(label: {
                Image(systemName: "tray.fill")
            }, description: {
                Text("Nothing to show")
            }, actions: {
            })
            .frame(width: UIScreen.main.bounds.width)
        } else {
            VStack(alignment: .leading) {
                Text("Recent searches")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                ScrollView(.horizontal) {
                    //LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 50)), count: 1), spacing: 4) {
                    LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 5, maximum: 5)), count: 1), spacing: 7) {
                        ForEach(0..<listCount, id: \.self) { index in
                            ShowSearchItem2(term: listSearchTerms.item[index].term)
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
    
    @ViewBuilder
    func ShowSearchItem2(term: String) -> some View {
        Button(action: {
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
//    RecentSearchTermsView2(listSearchTerms: previewCacheSearchTerms)
//}
