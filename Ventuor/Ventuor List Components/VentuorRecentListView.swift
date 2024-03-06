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
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    @ObservedObject var ventuorViewModel: VentuorViewModel

    @State var showVentuorPage: Bool = false
    
    var body: some View {
        let recentVentuors = userProfileModel.userRecentVentuors.getUserVentuors(userKey: Auth.shared.getUserKey() ?? "")
        NavigationStack() {
            let listCount = recentVentuors.item.count
            ScrollView() {
                VStack(spacing: 10) {
                    ForEach(0..<listCount, id: \.self) { index in
                        if recentVentuors.item[index].userKey == Auth.shared.getUserKey() {
                            Button(action: {
                                ventuorViewModel.getVentuorState(ventuorKey: recentVentuors.item[index].ventuorKey)
                            }, label: {
                                VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                    
                                    HStack() {
                                        let ventuorKey = recentVentuors.item[index].ventuorKey
                                        let liveMode = false
                                        RemoteLogoImage(
                                            ventuorKey: recentVentuors.item[index].ventuorKey,
                                            liveMode: liveMode,
                                            placeholderImage: Image("missing"), // Image(systemName: "photo"),
                                            logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: liveMode))
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .padding(0)
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(recentVentuors.item[index].title)
                                                .fontWeight(.regular)
                                                .font(.title2)
                                                .padding(0)
                                            Text(recentVentuors.item[index].subTitle1)
                                                .padding(.top, -3)
                                                .padding(.bottom, 2)
                                                .font(.caption)
                                                .fontWeight(.medium)
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
            .background(Color("ventuor-gray"))
        }
        .navigationDestination(isPresented: $ventuorViewModel.ventuorStateLive, destination: {
            VentuorView(ventuorViewModel: ventuorViewModel)
        })
        .navigationTitle(title)
        .overlay {
            if recentVentuors.item.count == 0 {
                ContentUnavailableView(label: {
                    Image(systemName: "tray.fill")
                }, description: {
                    Text("Nothing to show")
                }, actions: {
                })
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}

#Preview {
    VentuorRecentListView(title: "Test", homeViewModel: HomeViewModel.sample, ventuorViewModel: VentuorViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
