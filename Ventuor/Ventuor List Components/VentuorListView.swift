//
//  VentuorListView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/17/24.
//

import SwiftUI
import SwiftData

struct VentuorListView: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    var title: String
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()

    @State var showVentuorPage: Bool = false
    
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
                            }, label: {
                                VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                                                        
                                    HStack() {
                                        let ventuorKey = homeViewModel.ventuorList?.result?.ventuors?[index].ventuorKey ?? ""
                                        let liveMode = homeViewModel.ventuorList?.result?.ventuors?[index].liveMode ?? true
                                        RemoteLogoImage(
                                            ventuorKey: ventuorKey,
                                            liveMode: liveMode,
                                            placeholderImage: Image("missing"), // Image(systemName: "photo"),
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
                .environmentObject(UserProfileModel.shared)
        })
        .navigationTitle(title)
    }
}

#Preview {
    VentuorListView(title: "Test", homeViewModel: HomeViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
