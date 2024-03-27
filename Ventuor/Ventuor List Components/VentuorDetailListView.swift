//
//  VentuorDetailListView.swift
//  Ventuor
//
//  Created by Sam Dean on 2/29/24.
//

import SwiftUI

struct VentuorDetailListView: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    @State var liveMode: Bool
    @ObservedObject var ventuorViewModel: VentuorViewModel
    var title: String

    @Binding var ventuors: [VentuorData]
    @Binding var displayStatusMessage: String
    
    var body: some View {
        NavigationStack() {
            let listCount = ventuors.count
            ScrollView() {
                VStack(spacing: 10) {
                    ForEach(0..<listCount, id: \.self) { index in
                        Button(action: {
                            ventuorViewModel.setUserProfileModel(userProfileModel: userProfileModel)
                            ventuorViewModel.getVentuorData(ventuorKey: ventuors[index].ventuorKey ?? "", liveMode: ventuors[index].liveMode ?? true)
                        }, label: {
                            VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                
                                HStack() {
                                    let ventuorKey = ventuors[index].ventuorKey ?? ""
                                    let liveMode = ventuors[index].liveMode ?? true
                                    RemoteLogoImage(
                                        ventuorKey: ventuorKey,
                                        liveMode: liveMode,
                                        placeholderImage: Image("missing"), // Image(systemName: "photo"),
                                        logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: liveMode))
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(0)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(ventuors[index].title ?? "")
                                            .fontWeight(.regular)
                                            .font(.title2)
                                            .padding(0)
                                            .foregroundColor(.ventuorBlue)
                                        if let subTitle1 = ventuors[index].subTitle1 {
                                            if !subTitle1.isEmpty {
                                                Text(subTitle1)
                                                    .padding(.top, -3)
//                                                    .padding(.bottom, 2)
                                                    .font(.system(size: 12))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        if let subTitle2 = ventuors[index].subTitle2 {
                                            Text(subTitle2)
                                                .fontWeight(.light)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                                .padding(0)
                                        }
                                    }
                                    .lineLimit(1)
                                    .padding(.leading, 2)
                                    
                                    Spacer()
                                }
                                
                                VentuorTitleOpenClosedTimeframeStatus(status: ventuors[index].status ?? "", statusMessage: ventuors[index].statusMessage ?? "",
                                                                      timeframeStatus: ventuors[index].timeframeStatus ?? "",
                                                                      timeframeStatusMessage: ventuors[index].timeframeStatusMessage ?? "")
                                
                            }
                            .padding(10)
                            .background(.white)
                            .overlay(alignment: .topTrailing, content: {
                                VentuorTimeframeBanner(
                                    timeframeStatus: ventuors[index].timeframeStatus ?? "",
                                    timeframeStatusMessage: ventuors[index].timeframeStatusMessage ?? "")
                            })
                            .cornerRadius(0)
//                            .shadow(color: .ventuorLightGray, radius: 2, x: 1, y: 1)
                            
                            Divider()
                        })
                    }
                    .padding([.leading, .trailing], 0)
                    .errorAlert(error: $ventuorViewModel.errorVentuorState)
                }
                .padding(.bottom, 70)
            }
        }
        .navigationDestination(isPresented: $ventuorViewModel.ventuorStateLive, destination: {
            VentuorView(ventuorViewModel: ventuorViewModel)
                .environmentObject(UserProfileModel.shared)
        })
        .navigationTitle(title)
        .overlay {
            if ventuors.count == 0 {
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

//#Preview {
//    VentuorDetailListView(title: "", ventuors: .constant([VentuorData]()), displayStatusMessage: .constant(""))
//        .environmentObject(UserProfileModel.shared)
//}
