//
//  UserEmailLink.swift
//  Ventuor
//
//  Created by Sam Dean on 2/9/24.
//

import SwiftUI

struct EmailLink: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    var body: some View {
            Button(action: {
                userProfileModel.showEmailProfileSheet = true
            }, label: {
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundColor(.ventuorBlue)
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
            .sheet(isPresented: $userProfileModel.showEmailProfileSheet) {
                EmailView(email: userProfileModel.userProfileDataModel.email, 
                          isPresented: $userProfileModel.showEmailProfileSheet)
                    .presentationDragIndicator(.automatic)
                    .background(Color.white)
            }
    }
}

#Preview {
    EmailLink()
        .environmentObject(UserProfileModel.shared)
}
