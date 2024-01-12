//
//  VentuorNavigationButtonView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/12/24.
//

import SwiftUI

struct VentuorNavButtonView: View {
    var imageName: String
    var buttonText: String
    
    var body: some View {
        VStack(spacing: 7) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
            Text(buttonText)
                .foregroundColor(.ventuorGray)
                .font(.footnote)
                .padding(.bottom, -8)
        }
        .frame(width: 73, height: 70)
        .background(Color.ventuorBlue)
        .cornerRadius(10)
    }
}

#Preview {
    VentuorNavButtonView(imageName: "parkW", buttonText: "PARK")
}
