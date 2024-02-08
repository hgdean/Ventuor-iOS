//
//  VentuorRecentList.swift
//  Ventuor
//
//  Created by Sam Dean on 2/7/24.
//

import SwiftUI
import SwiftData

// This method is using the CacheUserProfile with RecentVentuors list for the recent ventuors
struct VentuorRecentListView2: View {
    var title: String
    @State var recentVentuors: [RecentVentuor]
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()

    @State var showVentuorPage: Bool = false

    @Environment(\.modelContext) private var context
    @Query(sort: \CacheUserProfile.userKey) var cacheUserProfiles: [CacheUserProfile]

    var body: some View {
        NavigationStack() {
            let listCount = cacheUserProfiles.count
            ScrollView() {
                VStack(spacing: 10) {
                    ForEach(0..<listCount, id: \.self) { index in
                        if cacheUserProfiles[index].userKey == Auth.shared.getUserKey() {
                            ForEach(0..<cacheUserProfiles[index].recentVentuors.count, id: \.self) { index2 in
                                Button(action: {
                                    //ventuorViewModel.getVentuorState(ventuorKey: recentVentuors[index].ventuorKey)
                                }, label: {
                                    VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                        
                                        HStack() {
                                            let ventuorKey = cacheUserProfiles[index].recentVentuors[index2].ventuorKey
                                            let liveMode = false
                                            RemoteLogoImage(
                                                ventuorKey: cacheUserProfiles[index].recentVentuors[index2].ventuorKey,
                                                liveMode: liveMode,
                                                placeholderImage: Image(systemName: "photo"),
                                                logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: liveMode))
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                            .padding(0)
                                            
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(cacheUserProfiles[index].recentVentuors[index2].title)
                                                    .fontWeight(.regular)
                                                    .font(.title2)
                                                    .padding(0)
                                                Text(cacheUserProfiles[index].recentVentuors[index2].subTitle1)
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
                                    .shadow(color: .ventuorDarkGray, radius: 2, x: 1, y: 1)
                                })
                            }
                        }
                    }
//                    ForEach(cacheUserProfiles) { cacheUserProfile in
//                        if cacheUserProfile.userKey == Auth.shared.getUserKey() {
//                            ForEach(cacheUserProfile.recentVentuors) { recentVentuor in
//                                
//                            }
//                            .padding([.leading, .trailing], 12)
//                            .errorAlert(error: $ventuorViewModel.errorVentuorState)
//                        }
//                    }
                }
                .padding(.bottom, 70)
            }
            .background(Color("ventuor-light-gray"))
        }
        .navigationDestination(isPresented: $ventuorViewModel.ventuorStateLive, destination: {
            VentuorView(ventuorViewModel: ventuorViewModel)
        })
        .navigationTitle(title)
        .overlay {
//            if recentVentuors.count == 0 {
//                ContentUnavailableView(label: {
//                    Label("", systemImage: "tray.fill")
//                }, description: {
//                    Text(homeViewModel.displayStatusMessage ?? "")
//                }, actions: {
//                    
//                })
//                .frame(width: UIScreen.main.bounds.width)
//            }
        }
        .onAppear() {
//            if let currentCacheUserProfile = getCurrentCacheUserProfile() {
//                recentVentuors = currentCacheUserProfile.recentVentuors
//                print(currentCacheUserProfile.recentVentuors.count)
//            }
        }
    }
    func getCurrentCacheUserProfile() -> CacheUserProfile? {
        for i in 0..<(self.cacheUserProfiles.count) {
            print(cacheUserProfiles[i].userKey)
            if cacheUserProfiles[i].userKey == Auth.shared.getUserKey() {
                return cacheUserProfiles[i]
            }
        }
        return nil
    }
}

#Preview {
    VentuorRecentListView2(title: "Test", recentVentuors: HomeViewModel.sample.recentVentuors, homeViewModel: HomeViewModel.sample)
}
