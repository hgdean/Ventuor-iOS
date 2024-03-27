//
//  ExploreViewTab.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/9/24.
//

import MapKit
import SwiftUI

struct ExploreViewTab: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View
    @StateObject var manager = LocationDataManager()
    
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    ))
    
    @State private var settingsDetentMedium = PresentationDetent.medium
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @ObservedObject var searchViewModel: SearchViewModel = SearchViewModel()
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel(liveMode: true)
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    @State var searchTerm: String = ""
    
    @Binding var activeTab: Tab
    
    @State private var showSearchSheet: Bool = false
    @State var showSheetForVentuor = false
    @State var navToShowVentuor: Bool = false
    @State var showSearchResultSheet: Bool = false
    //@State var showSearchResultButton: Bool = false
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationStack() {
            ZStack(alignment: .bottom) {
                Map() {
                    //                    Annotation(coordinate: CLLocationCoordinate2D(latitude: 42.0, longitude: -83)) {
                    //                        NavigationLink() {
                    //                        } label: {
                    //                            PlaceAnnotationView(ventuorViewModel: ventuorViewModel, ventuor: VentuorData(), navToShowVentuor: $navToShowVentuor, showSheetForVentuor: $showSheetForVentuor, title: "sgdfgsdfg")
                    //                        }
                    //                    } label: {
                    //                        Text("Test")
                    //                    }
                    
                    let count = searchViewModel.ventuors.count
//                    let count = homeViewModel.ventuors.count
                    ForEach(0..<count, id: \.self) { index in
                        // Marker(homeViewModel.ventuors[index].title ?? "", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(homeViewModel.ventuors[index].latitude ?? 0), longitude: CLLocationDegrees(homeViewModel.ventuors[index].longitude ?? 0)))
                        
                        Annotation(coordinate: CLLocationCoordinate2D(latitude: searchViewModel.ventuors[index].latitude ?? 42.5803, longitude: searchViewModel.ventuors[index].longitude ?? -83.0302)) {
                            NavigationLink() {
                                VentuorView(ventuorViewModel: ventuorViewModel)
                                    .navigationBarTitleDisplayMode(.inline)
                                    .environmentObject(UserProfileModel.shared)
                                    .task {
                                        showSearchResultSheet = false
                                        ventuorViewModel.setUserProfileModel(userProfileModel: userProfileModel)
                                        ventuorViewModel.getVentuorData(ventuorKey: searchViewModel.ventuors[index].ventuorKey ?? "", liveMode: true)
                                    }
                            } label: {
                                PlaceAnnotationView(ventuorViewModel: ventuorViewModel, ventuor: searchViewModel.ventuors[index], navToShowVentuor: $navToShowVentuor, showSheetForVentuor: $showSheetForVentuor, title: searchViewModel.ventuors[index].title ?? "")
                            }
                        } label: {
                            Text(searchViewModel.ventuors[index].title ?? "")
                        }
                    }
                }
                .mapStyle(.hybrid(elevation: .realistic,
                                  pointsOfInterest: .including([.publicTransport]),
                                  showsTraffic: true))
                .mapControls() {
                    //MapPitchToggle()
                    MapUserLocationButton()
                    MapCompass()
                }
                .navigationDestination(isPresented: $ventuorViewModel.ventuorStateLive, destination: {
                    VentuorView(ventuorViewModel: ventuorViewModel)
                        .navigationBarTitleDisplayMode(.inline)
                        .environmentObject(UserProfileModel.shared)
                        .task {
                            showSearchResultSheet = false
                        }
                })
                
                VStack() {
                    Button(action: {
                        showSearchSheet = true
                    }, label: {
                        Circle()
                            .fill(Color(.ventuorOrange))
                            .frame(height: 60)
                            .overlay(content: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)
                            })
                            .shadow(color: Color.black.opacity(0.7), radius: 5, x: 5, y:4)
                            .padding(.bottom, searchViewModel.searchResult ? 10 : 20)
                    })

                    if searchViewModel.searchResult {
                        ShowListResultButton(showSearchResultSheet: $showSearchResultSheet, settingsDetentMedium: $settingsDetentMedium)
                    } else {
//                        ShowListResultButton(showSearchResultSheet: $showSearchResultSheet, settingsDetentMedium: $settingsDetentMedium).hidden()
                    }
                }
                .sheet(isPresented: $showSearchSheet,
                       onDismiss: {
                            showSearchSheet = false
                }) {
                    VStack(alignment: .leading, spacing: 18) {
                        SearchBarView(searchText: $searchTerm)
                            .onSubmit {
                                doOnSubmitSearch(term: searchTerm)
                            }
                            .padding(.horizontal, 20)
                            .presentationDragIndicator(.visible)
                        
                        ScrollView() {
                            RecentSearchTermsView(listSearchTerms: userProfileModel.userRecentSearchTerms.getUserSearchItem(userKey: Auth.shared.getUserKey()!))
                                .padding(.horizontal, 20)

                            SearchCategoriesView()
                                .padding(.top, 25)
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top, 30)
                    .background(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .presentationDetents([.fraction(0.99)])
                    .presentationCornerRadius(25)
                    .presentationBackground(.regularMaterial)
                    .presentationBackgroundInteraction(.enabled)
                }
                .sheet(isPresented:
                    .constant(activeTab == Tab.explore && searchViewModel.searchResult && showSearchResultSheet),
                       onDismiss: {showSearchResultSheet = false}, content: {
                    VStack() {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(Color(.ventuorOrange))
                                .frame(height: 30)
                                .overlay(content: {
                                    Image(systemName: "magnifyingglass")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .shadow(radius: 2)
                                })
                            //.shadow(color: Color.black.opacity(0.7), radius: 5, x: 5, y:4)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(searchViewModel.searchTerm)
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    .lineLimit(1)
                                    .foregroundColor(.ventuorBlue)
                                HStack(spacing: 6) {
                                    Text("22 found")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    //Image(systemName: "circle.fill").font(.system(size: 4)).foregroundColor(.ventuorDarkGray)
                                }
                            }
                            Spacer()
                            Text("Clear")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .font(.callout)
                                .onTapGesture {
                                    searchViewModel.searchResult = false
                                    searchViewModel.ventuors = []
                                }
                        }
                        .padding([.top, .bottom], 20)
                        .padding([.leading, .trailing], 20)
                        
                        VentuorDetailListView(liveMode: true, ventuorViewModel: ventuorViewModel, title: "Search Result", ventuors: $searchViewModel.ventuors, displayStatusMessage: $searchViewModel.displayStatusMessage)
                        //.padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .presentationDetents([.height(140), .medium, .fraction(0.99)], selection: $settingsDetentMedium)
                            .presentationCornerRadius(25)
                            .presentationBackground(.ventuorLightGray)
                            .presentationBackgroundInteraction(.enabled)
                            .bottomMaskForSheet()
                    }
                })
                .padding(.bottom, 49)
            }
            .errorAlert(error: $searchViewModel.errorSearchResult)
        }
    }
    
    func doOnSubmitSearch(term: String) {
        showSearchSheet = false
        showSearchResultSheet = true
        addToRecentSearchTerms(term: term)
        searchViewModel.searchTerm = term
        settingsDetentMedium = PresentationDetent.medium
        
        searchViewModel.getVentuorListData()
        // homeViewModel.getAdminVentuorListInLive()
        // homeViewModel.getVentuorNearbyList()
    }
    
    func doOnSubmitSearchFromRecentSearchesButton(term: String) {
        showSearchSheet = false
        showSearchResultSheet = true
        addToRecentSearchTerms(term: term)
        searchViewModel.searchTerm = term
        searchTerm = term
        settingsDetentMedium = PresentationDetent.medium
        
        searchViewModel.getVentuorListData()
        // homeViewModel.getAdminVentuorListInLive()
        // homeViewModel.getVentuorNearbyList()
    }

    func doOnSubmitSearchFromSearcheCategory(term: String) {
        showSearchSheet = false
        showSearchResultSheet = true
        searchViewModel.searchTerm = term
        settingsDetentMedium = PresentationDetent.medium
        
        searchViewModel.getVentuorListData(category: term)
        // homeViewModel.getAdminVentuorListInLive()
        // homeViewModel.getVentuorNearbyList()
    }
    
    func addToRecentSearchTerms(term: String) {
        userProfileModel.addToRecentSearchTerms(cacheSearchItem: SearchItem(userKey: Auth.shared.getUserKey()!, term: term))
    }
    
    @ViewBuilder
    func RecentSearchTermsView(listSearchTerms: CacheSearchTerms) -> some View {
        let listCount = listSearchTerms.item.count
            VStack(alignment: .leading) {
                Text("Recent searches")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.ventuorBlue)
                
                if listCount == 0 {
                    ContentUnavailableView(label: {
                    }, description: {
                        VStack() {
                            Image(systemName: "tray.fill")
                            Text("Nothing to show")
                        }
                        .foregroundColor(Color.gray)
                    }, actions: {
                    })
                    .frame(height: 50)
                } else {
                ScrollView(.horizontal) {
                    //LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 50)), count: 1), spacing: 4) {
                    LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 5, maximum: 5)), count: 1), spacing: 7) {
                        ForEach(0..<listCount, id: \.self) { index in
                            ShowSearchItem(term: listSearchTerms.item[index].term)
                        }
                    }
                    .frame(height: 30)
                }
                //.padding(.leading, 17)
                //.background(Color.black)
                //.scrollPosition(id: $selectedTab)
                .scrollIndicators(.hidden)
                //.scrollTargetBehavior(.paging)
                .scrollClipDisabled()
            }
        }
    }
    
    @ViewBuilder
    func ShowSearchItem(term: String) -> some View {
        Button(action: {
            doOnSubmitSearchFromRecentSearchesButton(term: term)
        }, label: {
            ZStack() {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.ventuorLightGray))
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(term)
                            .font(.callout)
                            .fontWeight(.regular)
                            .lineLimit(1)
                            .foregroundColor(.ventuorBlue)
                    }
                }
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 5)
                .frame(maxWidth: 200)
                .frame(minWidth: 0)
            }
        })
    }
    
    let rowsA1: [GridItem] = [GridItem(.adaptive(minimum: 50, maximum: 100)),
                            GridItem(.adaptive(minimum: 50, maximum: 100))]
    let rowsA2: [GridItem] = [GridItem(.adaptive(minimum: 10, maximum: 10))]
    let rowsF1: [GridItem] = [GridItem(.fixed(30))]
    let rowsF2: [GridItem] = [GridItem(.fixed(30)),GridItem(.fixed(30))]
    let rowsFl3: [GridItem] = [GridItem(.flexible())]
    let rowsFl4: [GridItem] = [GridItem(.flexible(minimum: 100, maximum: 150)),
                             GridItem(.flexible(minimum: 100, maximum: 150))]
    let rowsFl5: [GridItem] = [GridItem(.flexible())]
    let rowsFl6: [GridItem] = [GridItem(.flexible(minimum: 100, maximum: 200))]
    let rowsFl8: [GridItem] = [GridItem(.flexible(minimum: 15, maximum: 15)),
                               GridItem(.flexible(minimum: 15, maximum: 15))]
    
    @ViewBuilder
    func SearchCategoriesView() -> some View {
        VStack(alignment: .leading) {
            Text("Search category")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.ventuorBlue)

            ScrollView(.horizontal) {
                LazyHGrid(rows: rowsFl5, spacing: 10) {
                    ForEach(0..<searchCategoryList1.count, id: \.self) { index in
                        ShowSearchCategoryItem(category: searchCategoryListAll1[index])
                            .padding(0)
                    }
                    .padding(0)
                }
                .padding(0)
                .frame(height: 30)
            }
            //.padding(.leading, 17)
            //.scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            //.scrollTargetBehavior(.paging)
            .scrollClipDisabled()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rowsFl5, spacing: 10) {
                        ForEach(0..<searchCategoryList2.count, id: \.self) { index in
                            ShowSearchCategoryItem(category: searchCategoryListAll2[index])
                                .padding(0)
                        }
                        .padding(0)
                    }
                    .padding(0)
                    .frame(height: 30)
                }
            //.padding(.leading, 17)
            //.background(Color.black)
            //.scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            //.scrollTargetBehavior(.paging)
            .scrollClipDisabled()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rowsFl5, spacing: 10) {
                        ForEach(0..<searchCategoryList3.count, id: \.self) { index in
                            ShowSearchCategoryItem(category: searchCategoryListAll3[index])
                                .padding(0)
                        }
                        .padding(0)
                    }
                    .padding(0)
                    .frame(height: 30)
            }
            //.padding(.leading, 17)
            //.background(Color.black)
            //.scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            //.scrollTargetBehavior(.paging)
            .scrollClipDisabled()
        }
    }
    
    @ViewBuilder
    func ShowSearchCategoryItem(category: Category) -> some View {
        Button(action: {
            doOnSubmitSearchFromSearcheCategory(term: category.title)
        }, label: {
            ZStack() {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(uiColor: UIColor.fromHexString(category.bgColor)))

                    VStack(alignment: .leading, spacing: 0) {
                        Text(category.title)
                            .font(.callout)
                            .fontWeight(.regular)
                            .lineLimit(1)
                            .foregroundColor(.ventuorBlue)
                    }
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 5)
                .frame(minWidth: 0)
            }
        })

    }

//    @ViewBuilder
//    func SearchCategoriesView2() -> some View {
//        VStack(alignment: .leading) {
//            Text("Search category")
//                .font(.title3)
//                .fontWeight(.semibold)
//            
//            ScrollView(.horizontal) {
////                LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 50)), count: 3), spacing: 4) {
////                LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 50, maximum: 150)), count: 2), spacing: 7) {
//                  LazyHGrid(rows: rowsA2, spacing: 10) {
//                    ForEach(0..<searchCategoryList.count, id: \.self) { index in
//                        ShowSearchCategoryItem(category: searchCategoryList[index])
//                            .padding(0)
//                            .background(Color.yellow)
//                    }
//                    .padding(0)
//                    .background(Color.blue)
//                }
//                .padding(0)
//                .frame(height: 130)
////                .frame(maxWidth: 800)
//                .background(Color.green)
//            }
//            //.padding(.leading, 17)
//            //.background(Color.black)
//            //.scrollPosition(id: $selectedTab)
//            .scrollIndicators(.hidden)
//            //.scrollTargetBehavior(.paging)
//            .scrollClipDisabled()
//        }
//    }
}

#Preview {
    ExploreViewTab(activeTab: .constant(Tab.explore))
        .environmentObject(UserProfileModel.shared)
}

struct ShowListResultButton: View {
    @Binding var showSearchResultSheet: Bool
    @Binding var settingsDetentMedium: PresentationDetent
    
    var body: some View {
        Button(action: {
            settingsDetentMedium = PresentationDetent.medium
            showSearchResultSheet = true
        }, label: {
            HStack {
                Text("SHOW LIST")
                    .fontWeight(.semibold)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.ventuorOrange)
            .background(.ventuorLightGray)
            .clipShape(
                .rect(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20
                )
            )
        })
    }
}

extension View {
    /// Fills in self with `fill`, maintaining self's natural size
    /// - Parameter fill: View to fill in self with (i.e., a gradient)
    /// - Returns: Filled-in version of self
    @ViewBuilder func filled(with fill: () -> some View) -> some View {
        self.overlay {
            fill().mask { self }
        }
    }
}

struct PlaceAnnotationView: View {
    var ventuorViewModel: VentuorViewModel
    var ventuor: VentuorData
    @Binding var navToShowVentuor: Bool
    @Binding var showSheetForVentuor: Bool
    
    @State private var showTitle = true
    
    let title: String
    
    var body: some View {
//        Button( action: {
//        }, label: {
            VStack(spacing: 0) {
                Text(title)
                    .font(.callout)
                    .padding(5)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .opacity(showTitle ? 0 : 1)
                
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    //.foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
                    .filled() {
                        LinearGradient(gradient: Gradient(colors: [.orange, .ventuorOrange, .red]), startPoint: .leading, endPoint: .trailing)
                    }
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                    .offset(x: 0, y: -5)
                    .filled() {
                        LinearGradient(gradient: Gradient(colors: [.orange, .ventuorOrange, .red]), startPoint: .leading, endPoint: .trailing)
                    }
            }
    }
}
