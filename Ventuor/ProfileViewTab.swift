//
//  ProfileViewTab.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/9/24.
//

import SwiftUI

struct ProfileViewTab: View {
    var body: some View {
        ScrollView() {
            VStack(spacing: 0) {
                NameLink()
                EmailLink()
                UsernameLink()
                PasswordLink()
            }
        }
    }
}

#Preview {
    ProfileViewTab()
}
