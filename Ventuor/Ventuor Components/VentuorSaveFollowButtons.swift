//
//  VentuorSaveFollowButtons.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/12/24.
//

import SwiftUI

struct VentuorSaveFollowButtons: View {
    var imageName: String
    var buttonText: String
    var selected: Bool = false

    var body: some View {
        VStack(spacing: 7) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
            Text(buttonText)
                .foregroundColor((selected == true) ? .ventuorOrange : .ventuorBlue)
                .fontWeight(.bold)
                .font(.caption2)
        }
        .frame(width: 73, height: 70)
    }
}

#Preview {
    VentuorSaveFollowButtons(imageName: "save-select", buttonText: "SAVE")
}
