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
    case settings = "Settings"
    case search = "Search"
    case admin = "Admin"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .profile:
            return "person"
        case .settings:
            return "gearshape"
        case .search:
            return "magnifyingglass.circle"
        case .admin:
            return "archivebox" // building.2.crop.circle storefront.circle folder.badge.gearshape
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
