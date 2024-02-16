//
//  AccountLink.swift
//  Ventuor
//
//  Created by Sam Dean on 2/16/24.
//

import SwiftUI

struct AccountLink: View {
    @EnvironmentObject var userProfileModel: UserProfileModel

    var body: some View {
        NavigationStack() {
            NavigationLink {
                AccountView()
            } label: {
                HStack(spacing: 20) {
                    Image(systemName: "person.crop.circle.badge")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    VStack(alignment: .leading) {
                        Text("Account")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .scaledToFit()
                        .padding([.top, .bottom], 20)
                        .foregroundColor(.ventuorBlue)
                        .opacity(0.3)
                        .frame(width: 20)
                }
                .padding([.leading, .trailing], 20)
                .border(width: 1, edges: [.bottom], color: .ventuorGray)
            }
            .background(Color(.white))
        }
    }
}

#Preview {
    AccountLink()
        .environmentObject(UserProfileModel.shared)
}

