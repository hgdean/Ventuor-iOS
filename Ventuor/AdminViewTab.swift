//
//  AdminViewTab.swift
//  Ventuor
//
//  Created by Sam Dean on 3/19/24.
//

import SwiftUI

struct AdminViewTab: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View
    @Binding var activeTab: Tab

    var body: some View {
        NavigationStack() {
            if !userProfileModel.userProfileDataModel.roles.contains(UserRole.ROLE_SUPER_USER.rawValue) {
                StartViewPage(showAdminStartPage: .constant(true))
            } else {
                VentuorAdminLandingPage()
            }
        }
    }
}

#Preview {
    AdminViewTab(activeTab: .constant(Tab.admin))
        .environmentObject(UserProfileModel.shared)
}
