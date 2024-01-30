//
//  VentuorSaveFollowButtons.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/12/24.
//

import SwiftUI

struct VentuorSaveButton: View {
    var selected: Bool = false
    @ObservedObject var ventuorViewModel: VentuorViewModel
    
    var body: some View {
        Button(action: {
            let ventuor = ventuorViewModel.ventuor?.result?.ventuor
            if !ventuorViewModel.isVentuorSavedByUser {
                ventuorViewModel.saveVentuor(ventuorKey: ventuor?.ventuorKey ?? "", title: ventuor?.title ?? "", subtitle1: ventuor?.subTitle1 ?? "", iconLocation: ventuor?.icon ?? "")
            } else {
                ventuorViewModel.unSaveVentuor(ventuorKey: ventuor?.ventuorKey ?? "")
            }
        }, label: {
            VStack(spacing: 7) {
                Image(systemName: "bookmark.square")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(Color(ventuorViewModel.isVentuorSavedByUser ? .ventuorOrange : .ventuorBlue))
                    .offset(y: 0)
//                Image(imageName + (ventuorViewModel.isVentuorSavedByUser ? "-on" : "-off"))
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 28, height: 28)
                Text((ventuorViewModel.isVentuorSavedByUser) ? "SAVED" : "SAVE")
                    .foregroundColor((ventuorViewModel.isVentuorSavedByUser) ? .ventuorOrange : .ventuorBlue)
                    .fontWeight(.bold)
                    .font(.caption2)
            }
            .frame(width: 73, height: 70)
        })
    }
}
