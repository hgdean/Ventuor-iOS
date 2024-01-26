//
//  VentuorTimeframeBanner.swift
//  Ventuor
//
//  Created by Sam Dean on 1/24/24.
//

import SwiftUI

struct VentuorTimeframeBanner: View {
    var timeframeStatus: String
    var timeframeStatusMessage: String

    var body: some View {
        if timeframeStatus == TimeframeStatus.COMING_SOON.rawValue {
            Image(.ventuorBannerComingsoon)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
        } else if timeframeStatus == TimeframeStatus.ENDED.rawValue {
            Image(.ventuorBannerEnded)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
        } else if timeframeStatus == TimeframeStatus.ENDING_SOON.rawValue {
            Image(.ventuorBannerEndingsoon)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
        } else if timeframeStatus == TimeframeStatus.AVAILABLE_NEW.rawValue {
            Image(.ventuorBannerNew)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
        } else if timeframeStatus == TimeframeStatus.LAST_DAY.rawValue {
            Image(.ventuorBannerLastday)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
        }
    }
}

#Preview {
    VentuorTimeframeBanner(timeframeStatus: "Ended", timeframeStatusMessage: "Ended Sunday, January 22, 2017")
}

