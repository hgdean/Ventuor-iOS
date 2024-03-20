//
//  Tab.swift
//  Ventuor
//
//  Created by Sam Dean on 1/24/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case profile = "Profile"
    case explore = "Explore"
    case admin = "Admin"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .profile:
            return "person"
        case .explore:
            return "safari"
        case .admin:
            return "storefront.circle" // building.2.crop.circle storefront.circle folder.badge.gearshape person.badge.key
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
