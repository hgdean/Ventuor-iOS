//
//  VentuorSearchItem.swift
//  Ventuor
//
//  Created by Sam Dean on 1/19/24.
//

import SwiftUI

struct VentuorSearchItem: View {
    @Binding var tabSelection: Int
    @Binding var activeTab: Tab

    var body: some View {
        HStack(spacing: 20) {
            Text("Search")
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
        .onTapGesture {
            tabSelection = 4
            activeTab = Tab.search
        }
    }
}

//#Preview {
//    VentuorSearchItem(tabSelection: .constant(1), activeTab: .constant(Tab.activity))
//}
