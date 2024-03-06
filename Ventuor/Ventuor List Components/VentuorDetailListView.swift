//
//  VentuorDetailListView.swift
//  Ventuor
//
//  Created by Sam Dean on 2/29/24.
//

import SwiftUI

struct VentuorDetailListView: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()

    var title: String

    @Binding var ventuors: [VentuorData]
    @Binding var displayStatusMessage: String
    
    var body: some View {
        NavigationStack() {
            let listCount = ventuors.count
            if displayStatusMessage != "Ready" {
                Text(displayStatusMessage)
            } else {
                ScrollView() {
                    VStack(spacing: 10) {
                        ForEach(0..<listCount, id: \.self) { index in
                            Button(action: {
                                ventuorViewModel.getVentuorState(ventuorKey: ventuors[index].ventuorKey ?? "")
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
                                        .frame(width: 60, height: 60)
                                        .padding(0)
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(ventuors[index].title ?? "")
                                                .fontWeight(.regular)
                                                .font(.title2)
                                                .padding(0)
                                            Text(ventuors[index].subTitle1 ?? "")
                                                .padding(.top, -3)
                                                .padding(.bottom, 2)
                                                .font(.caption)
                                                .fontWeight(.medium)
                                            Text(ventuors[index].subTitle2 ?? "")
                                                .fontWeight(.light)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                                .padding(0)
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
        .overlay {
            if ventuors.count == 0 {
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

//#Preview {
//    VentuorDetailListView(ventuors: Binding(projectedValue: [VentuorData](), displayStatusMessage: .constant(""))
//        .environmentObject(UserProfileModel.shared)
//}
