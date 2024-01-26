//
//  TimeframeStatus.swift
//  Ventuor
//
//  Created by Sam Dean on 1/24/24.
//

import Foundation

enum TimeframeStatus: String, CaseIterable {
    case COMING_SOON = "ComingSoon"
    case ENDING_SOON = "EndingSoon"
    case ENDED = "Ended"
    case LAST_DAY = "LastDay"
    case AVAILABLE_NEW = "AvailableNew"
    case AVAILABLE = "Available"
}
