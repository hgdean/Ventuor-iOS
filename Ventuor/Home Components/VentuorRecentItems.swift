//
//  VentuorRecentItems.swift
//  Ventuor
//
//  Created by Sam Dean on 1/20/24.
//

import SwiftUI

struct VentuorRecentItems: View {
    var body: some View {
        HStack(spacing: 20) {
            Text("RECENT VENTUORS")
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
            //
        }
    }
}

#Preview {
    VentuorRecentItems()
}
