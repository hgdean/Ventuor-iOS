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
    @EnvironmentObject var userProfileModel: UserProfileModel
    
    @State var showIntroScreens: Bool
    @AppStorage("shouldShowIntroScreens") var shouldShowIntroScreens: Bool = true

    @Environment(\.modelContext) private var context
    @Query(sort: \UserProfileDataModel.userKey) var userProfileDataModel: [UserProfileDataModel]

    var body: some View {

        VStack() {
//            if !shouldShowIntroScreens {
                if auth.loggedIn {
                    // MainTabView()
                    // MainTabView2()
                    // MainTabView3(showIntroScreens: false)
                    MainTabView4()
                        .onAppear() {
                            userProfileModel.loadUserProfile(cb: cbGetUserProfile)
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
    
    fileprivate func cbGetUserProfile(data: Data?, error: NSError?) -> Void {
        print(String(data: data!, encoding: .utf8)!)
        
        do {
            let response = try JSONDecoder().decode(UserProfile.self, from: data!)
            //print(response)
            
            if let profileDetails = response.result?.profileDetails {
                let loadedUserProfile = UserProfileDataModel(data: profileDetails)
                if !loadedUserProfile.userKey.isEmpty {
                    context.insert(loadedUserProfile)
                }
            }
        } catch {
        }
    }
}

#Preview {
    RootScreen(showIntroScreens: true)
}

