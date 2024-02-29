//
//  VentuorApp.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI
import SwiftData

@main
struct VentuorApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    @EnvironmentObject var auth: Auth
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserProfileDataModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()


    init() {
        // print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Auth.shared)
                .environmentObject(UserProfileModel.shared)
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: scenePhase) {
            if scenePhase == .background {
                UserProfileModel.shared.saveRecentVentuorsToStorage()
            }
            if scenePhase == .active {
                UserProfileModel.shared.loadRecentVentuorsFromStorage()
            }
        }
    }
}
