//
//  TinyVentuorItem.swift
//  Ventuor
//
//  Created by Sam Dean on 2/21/24.
//

import SwiftUI
import SwiftData

struct HorizontalViewList: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View
    
    @State private var selectedTab: TabRecentSavedFollow = .recent
    @Environment(\.colorScheme) private var scheme

    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()
    
    @State var showVentuorPage: Bool = false

    var body: some View {
        NavigationStack() {
            VStack(spacing: 10) {
                HStack(spacing: 0) {
                    ZStack() {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(self.selectedTab == TabRecentSavedFollow.recent ? Color(.ventuorOrange) : .clear)
                            .shadow(color: Color.black.opacity(0.6), radius: 3)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 5)
                        
                        Text("Recent")
                            .foregroundColor(self.selectedTab == TabRecentSavedFollow.recent ? .white : Color(.ventuorDarkGray).opacity(0.8))
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                    .background(Color.black.opacity(0.001))
                    .frame(height: 40, alignment: .leading)
                    //                .padding([.top, .bottom], 4)
                    //                .padding([.leading, .trailing], 4)
                    //                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                    .onTapGesture {
                        withAnimation(.default) {
                            selectedTab = TabRecentSavedFollow.recent
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
                    ZStack() {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(self.selectedTab == TabRecentSavedFollow.saved ? Color(.ventuorOrange) : .clear)
                            .shadow(color: Color.black.opacity(0.6), radius: 3)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 5)
                        
                        Text("Saved")
                            .foregroundColor(self.selectedTab == TabRecentSavedFollow.saved ? .white : Color(.ventuorDarkGray).opacity(0.8))
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                    .background(Color.black.opacity(0.001))
                    .frame(height: 40, alignment: .leading)
                    //                .padding([.top, .bottom], 4)
                    //                .padding([.leading, .trailing], 4)
                    //                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                    .onTapGesture {
                        withAnimation(.default) {
                            selectedTab = TabRecentSavedFollow.saved
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
                    ZStack() {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(self.selectedTab == TabRecentSavedFollow.follow ? Color(.ventuorOrange) : .clear)
                            .shadow(color: Color.black.opacity(0.6), radius: 3)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 5)
                        
                        Text("Follow")
                            .foregroundColor(self.selectedTab == TabRecentSavedFollow.follow ? .white : Color(.ventuorDarkGray).opacity(0.8))
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                    .background(Color.black.opacity(0.001))
                    .frame(height: 40, alignment: .leading)
                    //                .padding([.top, .bottom], 4)
                    //                .padding([.leading, .trailing], 4)
                    //                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                    .onTapGesture {
                        withAnimation(.default) {
                            selectedTab = TabRecentSavedFollow.follow
                        }
                    }
                }
                .background(Color.black.opacity(0.09))
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .circular))
                .padding(.horizontal)
                
                HStack(spacing: 0) {
                    switch selectedTab {
                    case .recent:
                        if userProfileModel.userRecentVentuors.item.count > 0 {
                            NavigationLink(destination: VentuorRecentListView(title: "Recent Ventuors", ventuorViewModel: VentuorViewModel()), label: {
                                Spacer()
                                Text("See all")
                                    .foregroundColor(Color(.blue))
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .padding(.trailing, 26)
                                    .padding([.top], 8)
                            })
                        }
                    case .saved:
                        NavigationLink(destination: VentuorCompactListView(title: "Saved Ventuors", savedFollowingVentuors: userProfileModel.userProfileDataModel?.savedVentuors ?? [], homeViewModel: homeViewModel, ventuorViewModel: VentuorViewModel()), label: {
                            Spacer()
                            Text("See all")
                                .foregroundColor(Color(.blue))
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding(.trailing, 26)
                                .padding([.top], 8)
                        })
                    case .follow:
                        NavigationLink(destination: VentuorCompactListView(title: "Following Ventuors", savedFollowingVentuors: userProfileModel.userProfileDataModel?.followingVentuors ?? [], homeViewModel: homeViewModel, ventuorViewModel: VentuorViewModel()), label: {
                            Spacer()
                            Text("See all")
                                .foregroundColor(Color(.blue))
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding(.trailing, 26)
                                .padding([.top], 8)
                        })
                    }
                }
                
                
                TabView(selection: self.$selectedTab) {
                    HRecentVentuorList()
                        .tag(TabRecentSavedFollow.recent)
                        .id(TabRecentSavedFollow.recent)
                        .containerRelativeFrame(.horizontal)
                    HVentuorList(userProfileModel.userProfileDataModel?.savedVentuors ?? [])
                        .tag(TabRecentSavedFollow.saved)
                        .id(TabRecentSavedFollow.saved)
                        .containerRelativeFrame(.horizontal)
                    HVentuorList(userProfileModel.userProfileDataModel?.followingVentuors ?? [])
                        .tag(TabRecentSavedFollow.follow)
                        .id(TabRecentSavedFollow.follow)
                        .containerRelativeFrame(.horizontal)
                }
                //.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                //.background(.green)
                .frame(height: 150)
                .errorAlert(error: $ventuorViewModel.errorVentuorState)
            }
            //.background(Color.cyan)
            //.frame(maxHeight: 300)
        }
        .navigationDestination(isPresented: $ventuorViewModel.ventuorStateLive, destination: {
            VentuorView(ventuorViewModel: ventuorViewModel)
        })
    }
    
    @ViewBuilder
    func HVentuorList(_ list: [SaveFollowVentuor]) -> some View {
        let listCount = list.count
        if listCount == 0 {
            ContentUnavailableView(label: {
                Image(systemName: "tray.fill")
            }, description: {
                Text("Nothing to show")
            }, actions: {
            })
            .frame(width: UIScreen.main.bounds.width)
        } else {
            ScrollView(.horizontal) {
                // LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 50)), count: 1), spacing: 0)
                LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 5, maximum: 5)), count: 1), spacing: 7, content: {
                    ForEach(0..<listCount, id: \.self) { index in
                        ShowVentuorItem(ventuorKey: list[index].ventuorKey ?? "", title: list[index].title ?? "", subTitle1: list[index].subTitle1 ?? "")
                    }
                })
                .frame(height: 100)
            }
            .padding(.leading, 17)
            //.background(Color.black)
            //.scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            //.scrollTargetBehavior(.paging)
            .scrollClipDisabled()
        }
    }
    
    @ViewBuilder
    func HRecentVentuorList() -> some View {
        let list = userProfileModel.userRecentVentuors.getUserVentuors(userKey: Auth.shared.getUserKey()!)
        let listCount = list.item.count
        if listCount == 0 {
            ContentUnavailableView(label: {
                Image(systemName: "tray.fill")
            }, description: {
                Text("Nothing to show")
            }, actions: {
            })
            .frame(width: UIScreen.main.bounds.width)
        } else {
            ScrollView(.horizontal) {
                // LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 50)), count: 1), spacing: 0)
                LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 5, maximum: 5)), count: 1), spacing: 7, content: {
                    ForEach(0..<listCount, id: \.self) { index in
                        ShowVentuorItem(ventuorKey: list.item[index].ventuorKey, title: list.item[index].title, subTitle1: list.item[index].subTitle1)
                    }
                })
                .frame(height: 100)
            }
            .padding(.leading, 17)
            //.background(Color.black)
            //.scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            //.scrollTargetBehavior(.paging)
            .scrollClipDisabled()
            
        }
    }

    @ViewBuilder
    func ShowVentuorItem(ventuorKey: String, title: String, subTitle1: String) -> some View {
        Button(action: {
            ventuorViewModel.getVentuorState(ventuorKey: ventuorKey)
        }, label: {
            ZStack() {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.ventuorGray))
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack(alignment: .top, spacing: 0) {
                        let ventuorKey = ventuorKey
                        let liveMode = false
                        RemoteLogoImage(
                            ventuorKey: ventuorKey,
                            liveMode: liveMode,
                            placeholderImage: Image("missing"), // Image(systemName: "photo"),
                            logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorKey, liveMode: liveMode))
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text(title)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .lineLimit(1)
                    }
                }
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 15)
                .frame(maxWidth: 165)
                .frame(minWidth: 110)
            }
        })
    }
}

#Preview {
    HorizontalViewList(homeViewModel: HomeViewModel.sample, ventuorViewModel: VentuorViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}

