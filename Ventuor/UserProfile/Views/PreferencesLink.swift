//
//  PreferencesLink.swift
//  Ventuor
//
//  Created by Sam Dean on 2/16/24.
//

import SwiftUI

enum Metric: String, CaseIterable {
    case miles = "Miles"
    case kilometers = "Kilometers"
}

struct PreferencesLink: View {
    @EnvironmentObject var userProfileModel: UserProfileModel

    @State var distanceMetric: Metric = SettingsInfo.distanceInMiles ? Metric.miles : Metric.kilometers

    var body: some View {
        NavigationStack() {
            NavigationLink {
                PreferencesView(selection: $distanceMetric)
            } label: {
                HStack(spacing: 20) {
                    Image(systemName: "checkmark.seal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    VStack(alignment: .leading) {
                        Text("Preferences")
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
    PreferencesLink()
        .environmentObject(UserProfileModel.shared)
}

