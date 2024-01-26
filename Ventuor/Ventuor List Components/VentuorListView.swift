//
//  VentuorListView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/17/24.
//

import SwiftUI

struct VentuorListView: View {
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
                                VStack(alignment: .leading, spacing: 8) {                         // Main header name / info
                                                                        
                                    HStack() {
                                        Image(homeViewModel.ventuorList?.result?.ventuors?[index].icon ?? "missing")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                            .padding(0)
                                            .background(.blue)
                                        
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
                                .shadow(radius: 1)
                            })
                        }
                        .padding([.leading, .trailing], 12)
                        .errorAlert(error: $ventuorViewModel.errorVentuorState)
//                        .alert(item: $ventuorViewModel.ventuorStateMessage) { message in
//                            return Alert(
//                                title: Text(""),
//                                message: Text(message.state.ErrorMsg),
//                                dismissButton: .cancel()
//                            )
//                        }
                    }
                    .padding(.bottom, 70)
                }
                .background(Color("ventuor-light-gray"))
                //.padding(0)
                //.padding([.bottom, .top], 0)        }
            }
        }
        .navigationDestination(isPresented: $ventuorViewModel.ventuorStateLive, destination: {
//            ventuorViewModel.getVentuorData(ventuorKey: homeViewModel.ventuorList?.result?.ventuors?[index].ventuorKey ?? "")

            VentuorView(ventuorViewModel: ventuorViewModel)
        })
        .navigationTitle(title)
    }
}

#Preview {
    VentuorListView(title: "Test", homeViewModel: HomeViewModel.sample)
}
