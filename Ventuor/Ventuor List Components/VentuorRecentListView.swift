//
//  VentuorRecentList.swift
//  Ventuor
//
//  Created by Sam Dean on 2/7/24.
//

import SwiftUI
import SwiftData

// This method is using the standalone CacheVentuor class for the recent ventuors
struct VentuorRecentListView: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    var title: String
    var recentVentuors2: CacheVentuor
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel(liveMode: true)

    @ObservedObject var homeViewModel: HomeViewModel
    @State var showVentuorPage: Bool = false
    
    var body: some View {
        NavigationStack() {
            let listCount = recentVentuors2.item.count
            ScrollView() {
                VStack(spacing: 2) {
                    ForEach(0..<listCount, id: \.self) { index in
                        if recentVentuors2.item[index].userKey == Auth.shared.getUserKey() {
                            Button(action: {
                                ventuorViewModel.setUserProfileModel(userProfileModel: userProfileModel)
                                ventuorViewModel.getVentuorData(ventuorKey: recentVentuors2.item[index].ventuorKey, liveMode: true)
                            }, label: {
                                VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                    
                                    HStack() {
                                        let ventuorKey = recentVentuors2.item[index].ventuorKey
                                        RemoteLogoImage(
                                            ventuorKey: recentVentuors2.item[index].ventuorKey,
                                            liveMode: true,
                                            placeholderImage: Image("missing"), // Image(systemName: "photo"),
                                            logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: true))
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .padding(0)
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(recentVentuors2.item[index].title)
                                                .fontWeight(.regular)
                                                .font(.title3)
                                                .padding(0)
                                                .foregroundColor(.ventuorBlue)
                                            Text(recentVentuors2.item[index].subTitle1)
                                                .padding(.top, -3)
                                                .padding(.bottom, 2)
                                                .fontWeight(.medium)
                                                .foregroundColor(.ventuorBlue)
                                                .font(.system(size: 12))
                                                .opacity(0.4)
                                        }
                                        .lineLimit(1)
                                        .padding(.leading, 2)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(10)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(color: .ventuorLightGray, radius: 2, x: 1, y: 1)
                            })
                        }
                    }
                    .padding([.leading, .trailing], 12)
                    .errorAlert(error: $ventuorViewModel.errorVentuorState)
                }
                .padding(.bottom, 70)
            }
            .background(Color.ventuorLightGray)
        }
        .navigationDestination(isPresented: $ventuorViewModel.ventuorStateLive, destination: {
            VentuorView(ventuorViewModel: ventuorViewModel)
        })
        .navigationTitle(title)
        .overlay {
            if recentVentuors2.item.count == 0 {
                ContentUnavailableView(label: {
                }, description: {
                    VStack() {
                        Image(systemName: "tray.fill")
                        Text("Nothing to show")
                    }
                    .foregroundColor(Color.gray)
                }, actions: {
                })
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color.ventuorBackgroundSplash)
            }
        }
    }
}

#Preview {
    VentuorRecentListView(title: "Test", recentVentuors2: CacheVentuor(), ventuorViewModel: VentuorViewModel.sample, homeViewModel: HomeViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
