//
//  VentuorListView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/17/24.
//

import SwiftUI
import SwiftData

struct VentuorListView: View {
    var title: String
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()

    @State var showVentuorPage: Bool = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \CachedVentuor.updated, order: .reverse) private var recentVentuors: [CachedVentuor]

    var body: some View {
        NavigationStack() {
            let listCount = homeViewModel.ventuorList?.result?.ventuors?.count ?? 0
            if homeViewModel.displayStatusMessage != "Ready" {
                Text(homeViewModel.displayStatusMessage ?? "")
            } else {
                ScrollView() {
                    VStack(spacing: 10) {
                        ForEach(0..<listCount, id: \.self) { index in
                            Button(action: {
                                ventuorViewModel.getVentuorState(ventuorKey: homeViewModel.ventuorList?.result?.ventuors?[index].ventuorKey ?? "")
                                
                                
//                                if let currentCacheUserProfile = getCurrentCacheUserProfile() {
//                                    let recentVentuor = RecentVentuor(userKey: Auth.shared.getUserKey()!, ventuorKey: homeViewModel.ventuorList?.result?.ventuors?[index].ventuorKey ?? "", title: homeViewModel.ventuorList?.result?.ventuors?[index].title ?? "", subTitle1: homeViewModel.ventuorList?.result?.ventuors?[index].subTitle1 ?? "")
//                                    currentCacheUserProfile.removeRecentVentuor(ventuorUserKey: recentVentuor.ventuorUserKey)
//                                    currentCacheUserProfile.addRecentVentuor(recentVentuor: recentVentuor)
//                                    try! context.save()
//                                }

                                addToRecentVentuor(index: index)
                                
                            }, label: {
                                VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                                                        
                                    HStack() {
                                        let ventuorKey = homeViewModel.ventuorList?.result?.ventuors?[index].ventuorKey ?? ""
                                        let liveMode = homeViewModel.ventuorList?.result?.ventuors?[index].liveMode ?? true
                                        RemoteLogoImage(
                                            ventuorKey: ventuorKey,
                                            liveMode: liveMode,
                                            placeholderImage: Image(systemName: "photo"),
                                            logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: liveMode))
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .padding(0)
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(homeViewModel.ventuorList?.result?.ventuors?[index].title ?? "")
                                                .fontWeight(.regular)
                                                .font(.title2)
                                                .padding(0)
                                            Text(homeViewModel.ventuorList?.result?.ventuors?[index].subTitle1 ?? "")
                                                .padding(.top, -3)
                                                .padding(.bottom, 2)
                                                .font(.caption)
                                                .fontWeight(.medium)
                                            Text(homeViewModel.ventuorList?.result?.ventuors?[index].subTitle2 ?? "")
                                                .fontWeight(.light)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                                .padding(0)
                                        }
                                        .lineLimit(1)
                                        .padding(.leading, 2)
                                        
                                        Spacer()
                                    }
                                    
                                    VentuorTitleOpenClosedTimeframeStatus(status: homeViewModel.ventuorList?.result?.ventuors?[index].status ?? "", statusMessage: homeViewModel.ventuorList?.result?.ventuors?[index].statusMessage ?? "",
                                        timeframeStatus: homeViewModel.ventuorList?.result?.ventuors?[index].timeframeStatus ?? "",
                                        timeframeStatusMessage: homeViewModel.ventuorList?.result?.ventuors?[index].timeframeStatusMessage ?? "")
                                    
                                }
                                .padding(10)
                                .background(.white)
                                .overlay(alignment: .topTrailing, content: {
                                    VentuorTimeframeBanner(
                                        timeframeStatus: homeViewModel.ventuorList?.result?.ventuors?[index].timeframeStatus ?? "",
                                        timeframeStatusMessage: homeViewModel.ventuorList?.result?.ventuors?[index].timeframeStatusMessage ?? "")
                                })
                                .cornerRadius(10)
                                .shadow(color: .ventuorLightGray, radius: 2, x: 1, y: 1)
                            })
                        }
                        .padding([.leading, .trailing], 12)
                        .errorAlert(error: $ventuorViewModel.errorVentuorState)
                    }
                    .padding(.bottom, 70)
                }
                .background(Color("ventuor-gray"))
            }
        }
        .navigationDestination(isPresented: $ventuorViewModel.ventuorStateLive, destination: {
            VentuorView(ventuorViewModel: ventuorViewModel)
        })
        .navigationTitle(title)
    }
    
    func addToRecentVentuor(index: Int) {
        let cachedVentuor = CachedVentuor(userKey: Auth.shared.getUserKey()!, ventuorKey: homeViewModel.ventuorList?.result?.ventuors?[index].ventuorKey ?? "", title: homeViewModel.ventuorList?.result?.ventuors?[index].title ?? "", subTitle1: homeViewModel.ventuorList?.result?.ventuors?[index].subTitle1 ?? "")
        
        homeViewModel.addToRecentVentuor(context: context, cachedVentuors: recentVentuors,
                                         cachedVentuor: cachedVentuor)
    }
}

#Preview {
    VentuorListView(title: "Test", homeViewModel: HomeViewModel.sample)
}
