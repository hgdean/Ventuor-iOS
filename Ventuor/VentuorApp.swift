//
//  VentuorApp.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI

@main
struct VentuorApp: App {
    @EnvironmentObject var auth: Auth

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Auth.shared)
        }
    }
}
