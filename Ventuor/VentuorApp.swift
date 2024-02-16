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
    @EnvironmentObject var userProfileModel: UserProfileModel

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserProfileDataModel.self, CachedVentuor.self
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
    }
}
