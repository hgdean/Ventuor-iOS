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
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel(liveMode: true)

    @State var showVentuorPage: Bool = false

    var body: some View {
        NavigationStack() {
            let listCount = savedFollowingVentuors.count
            ScrollView() {
                VStack(spacing: 2) {
                    ForEach(0..<listCount, id: \.self) { index in
                        Button(action: {
                            ventuorViewModel.setUserProfileModel(userProfileModel: userProfileModel)
                            ventuorViewModel.getVentuorData(ventuorKey: savedFollowingVentuors[index].ventuorKey ?? "", liveMode: true)
                        }, label: {
                            VStack(alignment: .leading, spacing: 8) {         // Main header name / info
                                HStack() {
                                    let ventuorKey = savedFollowingVentuors[index].ventuorKey ?? ""
                                    RemoteLogoImage(
                                        ventuorKey: ventuorKey,
                                        liveMode: true,
                                        placeholderImage: Image("missing"), // Image(systemName: "photo"),
                                        logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: true))
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
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color.ventuorBackgroundSplash)
            }
        }
    }
}

#Preview {
    VentuorCompactListView(title: "Test", savedFollowingVentuors: [SaveFollowVentuor](), homeViewModel: HomeViewModel.sample, ventuorViewModel: VentuorViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
