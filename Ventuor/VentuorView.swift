//
//  VentuorView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/10/24.
//

import SwiftUI
import SwiftData

struct VentuorView: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    @State var showParkingSheet = false
    @State var showDoorStepSheet = false
    
    @State var showHoursSheet = false
    @State var showDeptHoursSheet: DepartmentHours? = nil
    
    @ObservedObject var ventuorViewModel: VentuorViewModel

    @State var showVentuorKey: Bool = false
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 15) {
                VStack() {
                    VStack(alignment: .leading, spacing: 6) {                         // Main header name / info
                        
                        if let timeframeStatusMessage = ventuorViewModel.ventuor?.result?.ventuor?.timeframeStatusMessage {
                            Text(timeframeStatusMessage)
                                .foregroundColor(.ventuorEndedRed)
                                .fontWeight(.bold)
                                .italic()
                                .font(.caption)
                        }
                        
                        HStack() {
                            RemoteLogoImage(
                                ventuorKey: ventuorViewModel.ventuorKey,
                                liveMode: ventuorViewModel.ventuor?.result?.ventuor?.liveMode ?? true,
                                placeholderImage: Image("missing"), // Image(systemName: "photo"),
                                logoImageDownloader: DefaultLogoImageDownloader(ventuorKey: ventuorViewModel.ventuorKey, liveMode: ventuorViewModel.ventuor?.result?.ventuor?.liveMode ?? true))
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(0)
                            
                            VStack(alignment: .leading, spacing: 1) {
                                Text(ventuorViewModel.ventuor?.result?.ventuor?.title ?? "")
                                    .fontWeight(.thin)
                                    .font(.title)
                                    .padding(0)
                                HStack(alignment: .bottom) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        if let subTitle1 = ventuorViewModel.ventuor?.result?.ventuor?.subTitle1 {
                                            if !subTitle1.isEmpty {
                                                Text(subTitle1)
                                                    .padding(.top, -3)
//                                                    .padding(.bottom, 2)
                                                    .font(.system(size: 12))
                                                    .fontWeight(.medium)
                                            }
                                        }
                                        if let subTitle2 = ventuorViewModel.ventuor?.result?.ventuor?.subTitle2 {
                                            Text(subTitle2)
                                                .fontWeight(.light)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                                .padding(0)
                                        }
                                    }
                                }
                            }
                            .foregroundColor(.ventuorBlue)
                            .padding(.leading, 5)
                            .lineLimit(1)
                            
                            Spacer()
                        }
                        
                        VentuorTitleOpenClosedStatus(status: ventuorViewModel.ventuor?.result?.ventuor?.status ?? "", statusMessage: ventuorViewModel.ventuor?.result?.ventuor?.statusMessage ?? "", timeframeStatus: ventuorViewModel.ventuor?.result?.ventuor?.timeframeStatus ?? ""
                        )
                        
                    }
                    .padding(10)
                    .overlay(alignment: .topTrailing, content: {
                        VentuorTimeframeBanner(
                            timeframeStatus: ventuorViewModel.ventuor?.result?.ventuor?.timeframeStatus ?? "",
                            timeframeStatusMessage: ventuorViewModel.ventuor?.result?.ventuor?.timeframeStatusMessage ?? "")
                    })
                    .overlay(alignment: .bottomTrailing, content: {
                        Image(systemName: "key.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .padding(.trailing, 15)
                            .padding(.bottom, 10)
                            .foregroundColor(.ventuorOrange)
                            .opacity(1)
                            .frame(height: 26)
                            .onTapGesture {
                                self.showVentuorKey = true
                            }
                            .sheet(isPresented: self.$showVentuorKey, content: {
                                
                                let ventuorName = ventuorViewModel.ventuor?.result?.ventuor?.ventuorName ?? ""
                                VStack(spacing: 15) {
                                    HStack() {
                                        Text("Ventuor Key:")
                                        Text(ventuorName)
                                            .fontWeight(.semibold)
                                    }
                                    .font(.system(size: 14))
                                    .presentationDetents([.height(100)])
                                    .presentationCornerRadius(0)
                                    .presentationBackgroundInteraction(.disabled)
                                    .foregroundColor(Color.accentColor)
                                    
                                    Text("This is a unique identifier that can be used to locate a Ventuor.")
                                        .font(.footnote)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.gray)
                                    
                                    Spacer()
                                }
                                .padding(25)
                            })
                    })
                    .border(width: 1, edges: [.top, .bottom], color: .ventuorGray)
                    
                }
                
                VStack() {
                    let closedMessage = ventuorViewModel.ventuor?.result?.ventuor?.closedMessage ?? ""
                    if !closedMessage.isEmpty {
                        ZStack() {
                            HStack(alignment: .top, spacing: 20) {
                                Image("closed1")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.ventuorBlue)
                                    .frame(width: 25)
                                
                                Text(closedMessage)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.ventuorBlue)
                                    .fontWeight(.medium)
                                    .font(.system(size: 13))
                                    .lineSpacing(2)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .frame(maxHeight: 120)
                            
                            RoundedRectangle(
                                cornerRadius: 13,
                                style: .continuous
                            )
                            .stroke(.ventuorOrange , lineWidth: 3)
                            .frame(maxHeight: 155)
                            .padding(0)
                        }
                        .padding(.horizontal, 20)
                    }
                }

                VStack(alignment: .leading) {
                    HStack(spacing: 12) {
                        
                        VentuorMapsItem(ventuorViewModel: ventuorViewModel)
                        
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
                    .foregroundColor(.white)
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
                            .background(Color.white)
                    }
                    
                    HStack(spacing: 20) {
                        Image(systemName: "bitcoinsign.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        //                            .foregroundColor(.ventuorBlue)
                        
                        VStack(alignment: .leading) {
                            Text(ventuorViewModel.ventuor?.result?.ventuor?.payments ?? "Bitcoin, cash, VISA, MasterCard")
                                .lineLimit(1)
                            Text("Payment types excepted")
                                .fontWeight(.light)
                                .font(.caption)
                                .opacity(0.6)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "chevron.right.circle")
                            .resizable()
                            .scaledToFit()
                            .padding([.top, .bottom], 20)
                            .opacity(0.3)
                            .frame(width: 20)
                    }
                    .foregroundColor(.ventuorBlue)
                    .padding([.leading, .trailing], 15)
                    .border(width: 1, edges: [.bottom], color: .ventuorGray)
                }
                
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        VentuorSaveButton(ventuorViewModel: ventuorViewModel)
                        Spacer()
                        VentuorCheckinButton(ventuorViewModel: ventuorViewModel)
                        Spacer()
                        // arrowshape.zigzag.right.fill
                        VentuorFollowButton(ventuorViewModel: ventuorViewModel)
                        Spacer()
                        VentuorShareButton(ventuorViewModel: ventuorViewModel)
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
                .foregroundColor(.ventuorBlue)
                .padding(16)
                
                let pagesCount = ventuorViewModel.ventuor?.result?.ventuor?.pages?.count ?? 0
                if pagesCount > 0 {
                    VStack() {
                        VentuorPagesItem(pages: (ventuorViewModel.ventuor?.result?.ventuor?.pages)!)
                    }
                }
                
                if let photos = ventuorViewModel.ventuor?.result?.ventuor?.photos {
                    if photos.count > 0 {
                        VStack() {
                            VentuorPhotoHGrid(photos: ventuorViewModel.ventuor?.result?.ventuor?.photos ?? [ImageFileVO()],
                                              ventuor: ventuorViewModel.ventuor?.result?.ventuor ?? VentuorData())
                        }
                    }
                }
            }
            .padding(.bottom, 70)
        }
        .background(Color.white)
        .navigationTitle(String("*") + String(ventuorViewModel.ventuor?.result?.ventuor?.ventuorName ?? ""))
        .sheet(isPresented:
                .constant(ventuorViewModel.showBulletin),
               onDismiss: { ventuorViewModel.showBulletin = false }, content: {
            VStack(spacing: 15) {
                HStack(spacing: 12) {
                    Circle()
                        .fill(Color(.ventuorOrange))
                        .frame(height: 30)
                        .overlay(content: {
                            Image(systemName: "speaker.wave.1")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                        })
                    //.shadow(color: Color.black.opacity(0.7), radius: 5, x: 5, y:4)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Bulletin")
                            .fontWeight(.semibold)
                            .font(.title3)
                            .lineLimit(1)
                    }
                    Spacer()
                    Text("Close")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .font(.callout)
                        .onTapGesture {
                            ventuorViewModel.showBulletin = false
                        }
                }
                .foregroundColor(.ventuorBlue)
                .padding([.top], 20)
                .padding([.leading, .trailing], 20)
                
                Text(ventuorViewModel.ventuor?.result?.ventuor?.bulletin ?? "")
                    .padding([.leading, .trailing], 30)
                    .foregroundColor(.ventuorBlue)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .presentationDetents([.height(175), .medium])
            .presentationCornerRadius(25)
            .presentationBackground(.yellow)
            //.presentationBackgroundInteraction(.enabled)
            .bottomMaskForSheet()
        })
    }
}

#Preview {
    VentuorView(ventuorViewModel: VentuorViewModel.sample)
}

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
