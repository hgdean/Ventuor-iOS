//
//  VentuorCompactListView.swift
//  Ventuor
//
//  Created by Sam Dean on 2/1/24.
//
import SwiftUI
import SwiftData

struct VentuorCompactListView: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    var title: String
    var savedFollowingVentuors: [SaveFollowVentuor]
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()

    @State var showVentuorPage: Bool = false

    var body: some View {
        NavigationStack() {
            let listCount = savedFollowingVentuors.count
            ScrollView() {
                VStack(spacing: 2) {
                    ForEach(0..<listCount, id: \.self) { index in
                        Button(action: {
                            ventuorViewModel.setUserProfileModel(userProfileModel: userProfileModel)
                            ventuorViewModel.getVentuorState(ventuorKey: savedFollowingVentuors[index].ventuorKey ?? "")
                        }, label: {
                            VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                HStack() {
                                    let ventuorKey = savedFollowingVentuors[index].ventuorKey ?? ""
                                    let liveMode = false
                                    RemoteLogoImage(
                                        ventuorKey: ventuorKey,
                                        liveMode: liveMode,
                                        placeholderImage: Image("missing"), // Image(systemName: "photo"),
                                        logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: liveMode))
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .padding(0)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(savedFollowingVentuors[index].title ?? "")
                                            .fontWeight(.regular)
                                            .font(.title3)
                                            .padding(0)
                                            .foregroundColor(.ventuorBlue)
                                        Text(savedFollowingVentuors[index].subTitle1 ?? "")
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
            if savedFollowingVentuors.count == 0 {
                ContentUnavailableView(label: {
                }, description: {
                    VStack() {
                        Image(systemName: "tray.fill")
                        Text("Nothing to show")
                    }
                    .foregroundColor(Color.gray)
                }, actions: {
                })
                .background(Color.white)
            }
        }
    }
}

#Preview {
    VentuorCompactListView(title: "Test", savedFollowingVentuors: [SaveFollowVentuor](), homeViewModel: HomeViewModel.sample, ventuorViewModel: VentuorViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
