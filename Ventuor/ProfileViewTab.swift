//
//  ProfileViewTab.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/9/24.
//

import SwiftUI

struct ProfileViewTab: View {
    @EnvironmentObject var userProfileModel: UserProfileModel

    var body: some View {
        NavigationStack() {
            ScrollView() {
                VStack(spacing: 25) {
                    VStack() {
                        ProfilePhoto()
                        Text(userProfileModel.userProfileDataModel?.fullname ?? "")
                            .font(.title)
                        Text(userProfileModel.userProfileDataModel?.email ?? "")
                            .font(.subheadline)
                        Text(userProfileModel.userProfileDataModel?.username ?? "")
                            .font(.subheadline)
                    }
                    VStack(spacing: 0) {
                        AccountLink()
                        PreferencesLink()
                    }
                }
            }
            .background(Color(.ventuorLightGray))
        }
    }
}

#Preview {
    ProfileViewTab()
        .environmentObject(UserProfileModel.shared)
}
