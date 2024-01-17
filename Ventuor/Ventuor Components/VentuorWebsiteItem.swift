//
//  VentuorWebsiteItem.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/13/24.
//

import SwiftUI

struct VentuorWebsiteItem: View {
    var urlName: String
    var imageName: String
    var name: String
    var text: String

    var body: some View {
        Link(destination: URL(string: "https://" + name)!, 
             label: {                                       // TODO: func for URL formatting
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
    VentuorWebsiteItem(urlName: "https://", imageName: "browse", name: "someUrlName", text: "website")
}
