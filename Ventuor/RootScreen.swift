//
//  RootScreen.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI
import SwiftData

struct RootScreen: View {
    @EnvironmentObject var auth: Auth
    @ObservedObject var userProfileModel: UserProfileModel = UserProfileModel()
    
    @State var showIntroScreens: Bool
    @AppStorage("shouldShowIntroScreens") var shouldShowIntroScreens: Bool = true

    @Environment(\.modelContext) private var context
    @Query(sort: \CacheUserProfile.userKey) var cacheUserProfiles: [CacheUserProfile]

    var body: some View {

        VStack() {
//            if !shouldShowIntroScreens {
                if Auth.shared.loggedIn {
                    // MainTabView()
                    // MainTabView2()
                    // MainTabView3(showIntroScreens: false)
                    MainTabView4()
                        .onReceive(userProfileModel.$cachedUserProfile, perform: { item in
                        })
                        .onAppear() {
                            userProfileModel.loadUserProfile(cb: cbGetVentuorState)
                        }
                } else {
                    LandingView()
                }
//            }
        }
        .fullScreenCover(isPresented: $shouldShowIntroScreens, content: {
            IntroScreens(showIntroScreens: $shouldShowIntroScreens)
        })
    }
    
    fileprivate func cbGetVentuorState(data: Data?, error: NSError?) -> Void {
        print(String(data: data!, encoding: .utf8)!)
        
        do {
            do {
                let response = try JSONDecoder().decode(UserProfile.self, from: data!)
                //print(response)
                
                if let profileDetails = response.result?.profileDetails {
                    let loadedUserProfile = CacheUserProfile(data: profileDetails)
                    if !loadedUserProfile.userKey.isEmpty {
                        context.insert(loadedUserProfile)
                    }
                }
            } catch {
            }
        }
    }
}

#Preview {
    RootScreen(showIntroScreens: true)
}

