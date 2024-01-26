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
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
