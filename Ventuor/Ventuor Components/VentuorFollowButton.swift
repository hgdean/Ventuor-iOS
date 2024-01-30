//
//  VentuorSaveFollowButtons.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/12/24.
//

import SwiftUI

struct VentuorFollowButton: View {
    @ObservedObject var ventuorViewModel: VentuorViewModel
    
    var body: some View {
        Button(action: {
            let ventuor = ventuorViewModel.ventuor?.result?.ventuor
            if !ventuorViewModel.isVentuorFollowedByUser {
                ventuorViewModel.followVentuor(ventuorKey: ventuor?.ventuorKey ?? "", title: ventuor?.title ?? "", subtitle1: ventuor?.subTitle1 ?? "", iconLocation: ventuor?.icon ?? "")
            } else {
                ventuorViewModel.unFollowVentuor(ventuorKey: ventuor?.ventuorKey ?? "")
            }
        }, label: {
            VStack(spacing: 7) {
                Image(systemName: "checkmark.gobackward")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(Color(ventuorViewModel.isVentuorFollowedByUser ? .ventuorOrange : .ventuorBlue))
                    .offset(y: 0)
                Text((ventuorViewModel.isVentuorFollowedByUser) ? "FOLLOWING" : "FOLLOW")
                    .foregroundColor((ventuorViewModel.isVentuorFollowedByUser) ? .ventuorOrange : .ventuorBlue)
                    .fontWeight(.bold)
                    .font(.caption2)
            }
            .frame(width: 73, height: 70)
        })
    }
}
