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
    @EnvironmentObject var auth: Auth
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CacheUserProfile.self, CachedVentuor.self
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
        }
        .modelContainer(sharedModelContainer)
//        .modelContainer(for: [CacheUserProfile.self, CachedVentuor.self], inMemory: false, isAutosaveEnabled: true)
    }
}
