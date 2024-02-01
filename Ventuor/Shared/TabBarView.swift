//
//  TabBarView.swift
//  PhotoGalleryApp
//
//  Created by Sam Dean on 1/31/24.
//

import SwiftUI

struct sideBar1: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
    var tab: Tab
    var index: Int
}
let sidebar1 = [
    sideBar1(icon: "house", title: "Home", tab: .home, index: 2),
    sideBar1(icon: "person", title: "Profile", tab: .profile, index: 4),
    sideBar1(icon: "gearshape", title: "Settings", tab: .settings, index: 0),
    sideBar1(icon: "magnifyingglass.circle", title: "Search", tab: .search, index: 1),
    sideBar1(icon: "archivebox", title: "Admin", tab: .admin, index: 3),
    // building.2.crop.circle storefront.circle folder.badge.gearshape
]

struct TabBarView: View {
    @State var progress: CGFloat = 0.5
    @State var xOffset: CGFloat = 2 * 70.0
    @Binding var activeTab: Tab

    var body: some View {
        HStack {
            ForEach(sidebar1) { item in
                Spacer()
                Image(systemName: "\(item.icon)\(activeTab == item.tab ? ".fill" : "")")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(activeTab == item.tab ?  .ventuorOrange : .ventuorDarkGray)
                    .onTapGesture {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
                            withAnimation() {
                                activeTab = item.tab
                            }
                        }
                    }
                Spacer()
            }
            .frame(width: 23.3, height: 23)
        }
        //.frame(maxWidth: UIScreen.main.bounds.width - 40)
        .frame(height: 73)
        .background(.ultraThickMaterial)
        .cornerRadius(20)
    }
}

#Preview {
    TabBarView(activeTab: .constant(Tab.home))
}
