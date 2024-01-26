//
//  VentuorTimeframeStatus.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/16/24.
//

import SwiftUI

struct VentuorTitleOpenClosedTimeframeStatus: View {
    var status: String
    var statusMessage: String
    var timeframeStatus: String
    var timeframeStatusMessage: String

    var body: some View {
        if timeframeStatus == TimeframeStatus.ENDED.rawValue || timeframeStatus == TimeframeStatus.COMING_SOON.rawValue {
            HStack() {
                Text(timeframeStatusMessage)
                    .italic()
                    .foregroundColor(.ventuorClosedRed)
                    .fontWeight(.medium)
                    .font(.system(size: 13))
                    .padding(0)
            }
        } else if status == "open" || status == "Closed" {
            HStack() {
                Image(status == "open" ? "ventuor-open-rectangle" : "ventuor-closed-rectangle")
                    .resizable()
                    //.scaledToFit()
                    .frame(width: 40, height: 18)
                Text(statusMessage)
                    .font(.system(size: 13))
                    .foregroundColor(status == "open" ? .ventuorOpenGreen : .ventuorClosedRed)
                    .fontWeight(.medium)
                    .font(.caption2)
                    .padding(0)
            }
        } else {
        }
    }
}

#Preview {
    VentuorTitleOpenClosedTimeframeStatus(status: "open", statusMessage: "Open until 9:00 PM", timeframeStatus: "Ended", timeframeStatusMessage: "Ended Sunday, January 22, 2017")
}
