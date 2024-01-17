//
//  VentuorTitleOpenClosedStatus.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/16/24.
//

import SwiftUI

struct VentuorTitleOpenClosedStatus: View {
    var status: String
    var statusMessage: String
            
    var body: some View {
        if status == "open" || status == "Closed" {
            HStack() {
                Image(status == "open" ? "ventuor-open-rectangle" : "ventuor-closed-rectangle")
                    .resizable()
                    //.scaledToFit()
                    .frame(width: 40, height: 18)
                Text(statusMessage)
                    .foregroundColor(status == "open" ? .ventuorOpenGreen : .ventuorClosedRed)
                    .fontWeight(.medium)
                    .font(.caption2)
                    .padding(0)
            }
        }
    }
}

#Preview {
    VentuorTitleOpenClosedStatus(status: "open", statusMessage: "Open until 9:00 PM")
}
