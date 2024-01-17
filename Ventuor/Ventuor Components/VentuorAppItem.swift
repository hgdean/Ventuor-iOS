//
//  VentuorAppItem.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/16/24.
//

import SwiftUI

struct VentuorAppItem: View {
    var urlName: String
    var imageName: String
    var name: String
    var text: String
    var appStoreUrl: String

    var body: some View {
        Button(action: {

            if urlName != "" {
                if let url = URL(string: urlName), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else if appStoreUrl != "" {
                    let appStoreUri = "itms-apps://apps.apple.com/app/id" + appStoreUrl
                    if let url = URL(string: appStoreUri), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }, label: {
            HStack(spacing: 20) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.ventuorBlue)

                VStack(alignment: .leading, spacing: 0) {
                    Text(text)
                        .fontWeight(.light)
                        .font(.caption)
                        .foregroundColor(.ventuorBlue)
                        .opacity(0.6)
                    Text(name)
                        .fontWeight(.medium)
                        .font(.system(size: 13))
                        .lineLimit(1)
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
            .padding([.leading, .trailing], 15)
            .border(width: 1, edges: [.bottom], color: .ventuorGray)
        })
    }
}

#Preview {
    VentuorAppItem(urlName: "twitter://", imageName: "twitter", name: "someUrlName", text: "Twitter", appStoreUrl: "375380948")
}
