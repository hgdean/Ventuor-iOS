//
//  VentuorRecentList.swift
//  Ventuor
//
//  Created by Sam Dean on 2/7/24.
//

import SwiftUI
import SwiftData

// This method is using the standalone CachedVentuor class for the recent ventuors
struct VentuorRecentListView: View {
    var title: String
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()

    @State var showVentuorPage: Bool = false

    @Environment(\.modelContext) private var context
    @Query(sort: \CachedVentuor.updated, order: .reverse) var cachedVentuors: [CachedVentuor]

    var body: some View {
        NavigationStack() {
            let listCount = cachedVentuors.count
            ScrollView() {
                VStack(spacing: 10) {
                    ForEach(0..<listCount, id: \.self) { index in
                        if cachedVentuors[index].userKey == Auth.shared.getUserKey() {
                            Button(action: {
                                ventuorViewModel.getVentuorState(ventuorKey: cachedVentuors[index].ventuorKey)
                                
                                addToRecentVentuor(index: index)
                            }, label: {
                                VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                    
                                    HStack() {
                                        let ventuorKey = cachedVentuors[index].ventuorKey
                                        let liveMode = false
                                        RemoteLogoImage(
                                            ventuorKey: cachedVentuors[index].ventuorKey,
                                            liveMode: liveMode,
                                            placeholderImage: Image(systemName: "photo"),
                                            logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: liveMode))
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .padding(0)
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(cachedVentuors[index].title)
                                                .fontWeight(.regular)
                                                .font(.title2)
                                                .padding(0)
                                            Text(cachedVentuors[index].subTitle1)
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
            if cachedVentuors.count == 0 {
                ContentUnavailableView(label: {
                    Label("", systemImage: "tray.fill")
                }, description: {
                    Text(homeViewModel.displayStatusMessage ?? "")
                }, actions: {
                    
                })
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
    
    func addToRecentVentuor(index: Int) {
        let cachedVentuor = CachedVentuor(userKey: Auth.shared.getUserKey()!, ventuorKey: cachedVentuors[index].ventuorKey, title: cachedVentuors[index].title, subTitle1: cachedVentuors[index].subTitle1)

        homeViewModel.addToRecentVentuor(context: context, cachedVentuors: cachedVentuors,
                                         cachedVentuor: cachedVentuor)
    }

}

#Preview {
    VentuorRecentListView(title: "Test", homeViewModel: HomeViewModel.sample)
}
