//
//  PasswordLink.swift
//  Ventuor
//
//  Created by Sam Dean on 2/9/24.
//

import SwiftUI

struct PasswordLink: View {
    @EnvironmentObject var userProfileModel: UserProfileModel

    var body: some View {
            Button(action: {
                userProfileModel.showPasswordProfileSheet = true
            }, label: {
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Password")
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
            .sheet(isPresented: $userProfileModel.showPasswordProfileSheet) {
                PasswordView()
                    .presentationDragIndicator(.automatic)
            }
    }
}

#Preview {
    PasswordLink()
        .environmentObject(UserProfileModel.shared)
}

