//
//  NameLink.swift
//  Ventuor
//
//  Created by Sam Dean on 2/9/24.
//

import SwiftUI

struct NameLink: View {
    @EnvironmentObject var userProfileModel: UserProfileModel

    var body: some View {
            Button(action: {
                userProfileModel.showNameProfileSheet = true
            }, label: {
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Name")
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
            .sheet(isPresented: $userProfileModel.showNameProfileSheet) {
                NameView(fullname: userProfileModel.userProfileDataModel?.fullname ?? "")
                    .presentationDragIndicator(.automatic)
            }
    }
}

#Preview {
    NameLink()
        .environmentObject(UserProfileModel.shared)
}
