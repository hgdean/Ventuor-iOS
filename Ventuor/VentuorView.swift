//
//  VentuorView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/10/24.
//

import SwiftUI

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

struct VentuorView: View {

    @State var showParkingSheet = false
    @State var showDoorStepSheet = false
    
    @State var showHoursSheet = false
    @State var showDeptHoursSheet: DepartmentHours? = nil

    @ObservedObject var ventuorViewModel: VentuorViewModel
    
    var body: some View {
        ScrollView() {
            VStack() {
                VStack() {
                    VStack(alignment: .leading, spacing: 8) {                         // Main header name / info
                        
                        if let timeframeStatusMessage = ventuorViewModel.ventuor?.result?.ventuor?.timeframeStatusMessage {
                            Text(timeframeStatusMessage)
                                .foregroundColor(.ventuorEndedRed)
                                .fontWeight(.bold)
                                .italic()
                                .font(.caption)
                        }
                        
                        HStack() {
                            Image(ventuorViewModel.ventuor?.result?.ventuor?.icon ?? "missing")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .padding(0)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(ventuorViewModel.ventuor?.result?.ventuor?.title ?? "")
                                    .fontWeight(.thin)
                                    .font(.title)
                                    .padding(0)
                                Text(ventuorViewModel.ventuor?.result?.ventuor?.subTitle1 ?? "")
                                    .padding(.top, -3)
                                    .padding(.bottom, 2)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                Text(ventuorViewModel.ventuor?.result?.ventuor?.subTitle2 ?? "")
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .padding(0)
                            }
                            .padding(.leading, 5)
                            .background(.white)
                            .lineLimit(1)
                            
                            Spacer()
                        }
                        
                        VentuorTitleOpenClosedStatus(status: ventuorViewModel.ventuor?.result?.ventuor?.status ?? "", statusMessage: ventuorViewModel.ventuor?.result?.ventuor?.statusMessage ?? "",
                            timeframeStatus: ventuorViewModel.ventuor?.result?.ventuor?.timeframeStatus ?? ""
                            )
                        
                    }
                    .padding(10)
                    .overlay(alignment: .topTrailing, content: {
                        VentuorTimeframeBanner(
                            timeframeStatus: ventuorViewModel.ventuor?.result?.ventuor?.timeframeStatus ?? "",
                            timeframeStatusMessage: ventuorViewModel.ventuor?.result?.ventuor?.timeframeStatusMessage ?? "")
                    })
                    .border(width: 1, edges: [.top, .bottom], color: .ventuorGray)
                }
                
                VStack(alignment: .leading) {
                    HStack(spacing: 12) {

                        VentuorMapsItem()

                        VStack(spacing: 7) {
                            Image("driveW")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                            Text(ventuorViewModel.ventuor?.result?.ventuor?.distance ?? "")
                                .foregroundColor(.ventuorGray)
                                .font(.footnote)
                                .padding(.bottom, -8)
                        }
                        .frame(width: 73, height: 70)
                        .background(Color.ventuorBlue)
                        .cornerRadius(10)
 
                        if ventuorViewModel.ventuor?.result?.ventuor?.parking != "" {
                            Button(action: {
                                showParkingSheet = true
                            }, label: {
                                VentuorNavButtonView(imageName: "parkW", buttonText: "PARK")
                                    .sheet(isPresented: $showParkingSheet) {
                                        VentuorGenericSheet(title: "Parking", html: ventuorViewModel.ventuor?.result?.ventuor?.parking ?? "")
                                            .presentationDetents([.height(400), .medium, .large])
                                            .presentationDragIndicator(.automatic)
                                    }
                            })
                        }
                        
                        if ventuorViewModel.ventuor?.result?.ventuor?.doorStep != "" {
                            Button(action: {
                                showDoorStepSheet = true
                            }, label: {
                                VentuorNavButtonView(imageName: "walkW", buttonText: "DOOR")
                                    .sheet(isPresented: $showDoorStepSheet) {
                                        VentuorGenericSheet(title: "Door Step", html: ventuorViewModel.ventuor?.result?.ventuor?.doorStep ?? "")
                                            .presentationDetents([.height(400), .medium, .large])
                                            .presentationDragIndicator(.automatic)
                                    }
                            })
                        }
                                
                        Spacer()
                    }
                    .padding(.leading, 18)

                    HStack() {
                        Text(ventuorViewModel.ventuor?.result?.ventuor?.address ?? "")
                            .padding(5)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, minHeight: 70, alignment: .bottomTrailing)
                    .background(Color("ventuor-orange"))
                    .zIndex(-1)
                    .padding(.top, -50)
                    .shadow(radius: 5)
                    .lineLimit(1)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    VentuorCallItem(phone: ventuorViewModel.ventuor?.result?.ventuor?.phone ?? "", imageName: "call", countrycode: ventuorViewModel.ventuor?.result?.ventuor?.countrycode ?? "")

                    if ((ventuorViewModel.ventuor?.result?.ventuor?.showHours) != nil && (ventuorViewModel.ventuor?.result?.ventuor?.showHours == true)) {
                        VentuorHoursItem(status: ventuorViewModel.ventuor?.result?.ventuor?.status ?? "", showHoursSheet: showHoursSheet, hoursSplMsg: ventuorViewModel.ventuor?.result?.ventuor?.hoursSplMsg ?? "", hours: ventuorViewModel.ventuor?.result?.ventuor?.hours ?? "")
                    }

                    let departmentHoursCount = ventuorViewModel.ventuor?.result?.ventuor?.departmentHours?.count ?? 0
                    if departmentHoursCount > 0 {
                        VentuorDeptHoursItem(departmentHours: (ventuorViewModel.ventuor?.result?.ventuor?.departmentHours)!)
                    }
                    
                    HStack(spacing: 20) {
                        Image(systemName: "bitcoinsign.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.ventuorBlue)

                        VStack(alignment: .leading) {
                            Text(ventuorViewModel.ventuor?.result?.ventuor?.payments ?? "Bitcoin, cash, VISA, MasterCard")
                            Text("Payment types excepted")
                                .fontWeight(.light)
                                .font(.caption)
                                .foregroundColor(.ventuorBlue)
                                .opacity(0.6)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "chevron.right.circle")
                            .resizable()
                            .scaledToFit()
                            .padding([.top, .bottom], 20)
                            .foregroundColor(.ventuorBlue)
                            .opacity(0.3)
                            .frame(width: 20)
                    }
                    .padding([.leading, .trailing], 15)
                    .border(width: 1, edges: [.bottom], color: .ventuorGray)

                }
                
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        VentuorSaveFollowButtons(imageName: "save", buttonText: "SAVE", selected: false, ventuorViewModel: ventuorViewModel)
                        Spacer()
                        VentuorSaveFollowButtons(imageName: "check-in", buttonText: "CHECK-IN", selected: false, ventuorViewModel: ventuorViewModel)
                        Spacer()
                        VentuorSaveFollowButtons(imageName: "follow", buttonText: "FOLLOW", selected: false, ventuorViewModel: ventuorViewModel)
                        Spacer()
                        VentuorSaveFollowButtons(imageName: "share", buttonText: "SHARE", selected: false, ventuorViewModel: ventuorViewModel)
                    }
                    .padding([.leading, .trailing], 13)
                }

                VStack(alignment: .leading, spacing: 0) {
                    let url = ventuorViewModel.ventuor?.result?.ventuor?.webSiteUrl ?? ""
                    if url != "" {
                        VentuorWebsiteItem(urlName: "https://", imageName: "browse", name: ventuorViewModel.ventuor?.result?.ventuor?.webSiteUrl ?? "", text: "website")
                    }

                    let twitter = ventuorViewModel.ventuor?.result?.ventuor?.twitterHandle ?? ""
                    if twitter != "" {
                        VentuorFacebookItem(urlName: "twitter://", imageName: "twitter", name: ventuorViewModel.ventuor?.result?.ventuor?.twitterHandle ?? "", text: "Twitter")
                    }

                    let youtube = ventuorViewModel.ventuor?.result?.ventuor?.youtubeChannel ?? ""
                    if youtube != "" {
                        VentuorFacebookItem(urlName: "youtube://", imageName: "youtube", name: ventuorViewModel.ventuor?.result?.ventuor?.youtubeChannel ?? "", text: "YouTube Channel")
                    }

                    let facebook = ventuorViewModel.ventuor?.result?.ventuor?.facebook ?? ""
                    if facebook != "" {
                        VentuorFacebookItem(urlName: "fb://", imageName: "facebook", name: ventuorViewModel.ventuor?.result?.ventuor?.facebook ?? "", text: "Facebook Page")
                    }

                    let app = ventuorViewModel.ventuor?.result?.ventuor?.appName ?? ""
                    if app != "" {
                        VentuorAppItem(urlName: ventuorViewModel.ventuor?.result?.ventuor?.appUrl ?? "comgooglemaps://", imageName: "app", name: ventuorViewModel.ventuor?.result?.ventuor?.appName ?? "", text: "iOS App", appStoreUrl: ventuorViewModel.ventuor?.result?.ventuor?.appStoreUrl ?? "")
                    }
                }

                
                HStack(alignment: .center, spacing: 40) {
                    VStack(alignment: .center, spacing: 14) {
                        Button(action: {
                        }, label: {
                            Image(systemName: "plus.message.fill")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Color("ventuor-orange"))
                                // Lifting view
                                // if its selected
                                .offset(y: 0)
                        })
                        
                        Text("MESSAGE")
                            .fontWeight(.semibold)
                            .font(.caption)
                    }
                    .padding([.leading, .trailing], 13)

                    VStack(alignment: .center, spacing: 14) {
                        Button(action: {
                        }, label: {
                            
                            Image(systemName: "star.leadinghalf.filled")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Color("ventuor-orange"))
                                // Lifting view
                                // if its selected
                                .offset(y: 0)
                        })
                        
                        Text("REVIEW")
                            .fontWeight(.semibold)
                            .font(.caption)
                    }
                    .padding([.leading, .trailing], 13)

                    VStack(alignment: .center, spacing: 14) {
                        Button(action: {
                        }, label: {
                            
                            Image(systemName: "flag.square")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Color("ventuor-orange"))
                                // Lifting view
                                // if its selected
                                .offset(y: 0)
                        })
                        
                        Text("REPORT")
                            .fontWeight(.semibold)
                            .font(.caption)
                    }
                    .padding([.leading, .trailing], 13)
                }
                .padding(16)
                
                let pagesCount = ventuorViewModel.ventuor?.result?.ventuor?.pages?.count ?? 0
                if pagesCount > 0 {
                    VentuorPagesItem(pages: (ventuorViewModel.ventuor?.result?.ventuor?.pages)!)
                }

            }
            .padding(.bottom, 70)
        }

    }
}

#Preview {
    VentuorView(ventuorViewModel: VentuorViewModel.sample)
}
