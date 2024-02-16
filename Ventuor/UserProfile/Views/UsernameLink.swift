//
//  UsernameLink.swift
//  Ventuor
//
//  Created by Sam Dean on 2/9/24.
//

import SwiftUI

struct UsernameLink: View {
    @EnvironmentObject var userProfileModel: UserProfileModel

    var body: some View {
            Button(action: {
                userProfileModel.showUsernameProfileSheet = true
            }, label: {
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Username")
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
            })
            .background(Color(.white))
            .sheet(isPresented: $userProfileModel.showUsernameProfileSheet) {
                UsernameView(username: userProfileModel.userProfileDataModel?.username ?? "")
                    .presentationDragIndicator(.automatic)
            }
    }
}

#Preview {
    UsernameLink()
        .environmentObject(UserProfileModel.shared)
}

