//
//  VentuorSaveFollowButtons.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/12/24.
//

import SwiftUI

struct VentuorCheckinButton: View {
    @ObservedObject var ventuorViewModel: VentuorViewModel
    
    var body: some View {
        Button(action: {
            // let ventuor = ventuorViewModel.ventuor?.result?.ventuor
        }, label: {
            VStack(spacing: 7) {
                Image(systemName: "arrow.up.doc.on.clipboard")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(Color(ventuorViewModel.isVentuorCheckedinByUser ? .ventuorOrange : .ventuorBlue))
                    .offset(y: 0)
                Text("CHECK-IN")
                    .foregroundColor((ventuorViewModel.isVentuorCheckedinByUser == true) ? .ventuorOrange : .ventuorBlue)
                    .fontWeight(.bold)
                    .font(.caption2)
            }
            .frame(width: 73, height: 70)
        })
    }
}
