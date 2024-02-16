//
//  AccountView.swift
//  Ventuor
//
//  Created by Sam Dean on 2/16/24.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationStack() {
            VStack(spacing: 30) {
                VStack(spacing: 0) {
                    Divider()
                        .padding(.top, 50)

                    NameLink()
                    EmailLink()
                    UsernameLink()
                    PasswordLink()
                }
                
                VStack(spacing: 0) {
                    Divider()
                    LogoffLink()
                }
                VStack(spacing: 0) {
                    Divider()
                    LogoffLink2()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(UserProfileModel.shared)
}
