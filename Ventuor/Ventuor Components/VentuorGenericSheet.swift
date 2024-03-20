//
//  VentuorGenericSheet.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/12/24.
//

import SwiftUI

struct VentuorGenericSheet: View {
    
    @State var title: String
    @State var html: String = "<p>We are located in Somerset North.</p>\n<p>Near the Macy's store, on the first floor.</p>"
    @StateObject var locationDataManager = LocationDataManager()

    var body: some View {
        HStack() {
            Spacer()
            Text(title)
            Spacer()
        }
        .font(.title3)
        .foregroundColor(Color.white)
        .frame(height: 60)
        .background(Color.ventuorBlue)
        .ignoresSafeArea()

        HTMLRender(html: Utils().webMetaViewPort + html)
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 500, maxHeight: .infinity)
//            .padding()
            .background(Color.white)
    }
}

#Preview {
    VentuorGenericSheet(title: "Door Step", html: "<p>Example text for this sheet.</p>")
}
