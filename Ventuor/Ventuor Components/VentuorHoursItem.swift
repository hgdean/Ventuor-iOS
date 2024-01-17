//
//  VentuorHourItem.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/15/24.
//

import SwiftUI

struct VentuorHoursItem: View {
    var status: String
    @State var showHoursSheet = false
    var hoursSplMsg: String
    var hours: String

    var body: some View {
        if status != "" {
            Button(action: {
                showHoursSheet = true
            }, label: {
                HStack(spacing: 20) {
                    Image("open")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    VStack(alignment: .leading) {
                        Text("Hours")
                        Text(hoursSplMsg)
                            .fontWeight(.medium)
                            .font(.caption)
                            .foregroundColor(status == "open" ? .ventuorOpenGreen : .ventuorClosedRed)
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
                .sheet(isPresented: $showHoursSheet) {
                    VentuorHoursSheet(title: "Hours", hoursHtml: hours)
                        .presentationDetents([.height(500), .medium, .large])
                        .presentationDragIndicator(.automatic)
                }
            })
        }
    }
}

#Preview {
    VentuorHoursItem(status: "closed", hoursSplMsg: "Now Closed. Tomorrow: 7:00 AM - 7:00 PM", hours: "ZZZ")
}
