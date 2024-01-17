//
//  VentuorCallItem.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/13/24.
//

import SwiftUI

struct VentuorCallItem: View {
    var phone: String
    var imageName: String
    var countrycode: String
    
    var body: some View {
        let url = phone
        if url != "" {
            Link(destination: URL(string: "tel:" + phone)!, label: {
                HStack(spacing: 20) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    let phone = "Call:  " + (countrycode) + " " + (phone)
                    Text(phone)
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
}

#Preview {
    VentuorCallItem(phone: "2487908700", imageName: "call", countrycode: "+1")
}
