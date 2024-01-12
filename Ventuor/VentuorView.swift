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
    @State var showHoursSheet = false
    @State var showParkingSheet = false
    @State var showDoorStepSheet = false
    
    @ObservedObject var ventuorViewModel: VentuorViewModel = VentuorViewModel()

    init() {
        ventuorViewModel.getVentuorData()
    }
    var body: some View {
        ScrollView() {
            VStack() {
                VStack() {
                    VStack(alignment: .leading, spacing: 8) {                         // Main header name / info
                        
                        if let timeframeStatusMessage = ventuorViewModel.ventuorData?.timeframeStatusMessage {
                            Text(timeframeStatusMessage)
                                .foregroundColor(.ventuorEndedRed)
                                .fontWeight(.bold)
                                .italic()
                                .font(.caption)
                        }
                        
                        HStack() {
                            Image(ventuorViewModel.ventuorData?.icon ?? "missing")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .padding(0)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(ventuorViewModel.ventuorData?.title ?? "")
                                    .fontWeight(.thin)
                                    .font(.title)
                                    .padding(0)
                                Text(ventuorViewModel.ventuorData?.subTitle1 ?? "")
                                    .padding(.top, -3)
                                    .padding(.bottom, 2)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                Text(ventuorViewModel.ventuorData?.subTitle2 ?? "")
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .padding(0)
                            }
                            .padding(.leading, 5)
                            .background(.white)
                            
                            Spacer()
                        }
                        HStack() {
                            Image("ventuor-open-rectangle")
                                .resizable()
                                //.scaledToFit()
                                .frame(width: 40, height: 18)
                            Text(ventuorViewModel.ventuorData?.statusMessage ?? "")
                                .foregroundColor(.ventuorOpenGreen)
                                .fontWeight(.medium)
                                .font(.caption2)
                                .padding(0)
                        }
                    }
                    .padding(10)
                    .overlay(alignment: .topTrailing, content: {
                        Image(.ventuorBannerNew)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                    })
                    .border(width: 1, edges: [.top, .bottom], color: .ventuorGray)
                }
                
                VStack(alignment: .leading) {
                    HStack(spacing: 12) {

                            VStack(spacing: 7) {
                                Image("mapW")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                                Text("MAP")
                                    .foregroundColor(.ventuorGray)
                                    .font(.footnote)
                                    .padding(.bottom, -8)
                            }
                            .frame(width: 73, height: 70)
                            .background(Color.ventuorBlue)
                            .cornerRadius(10)

                            VStack(spacing: 7) {
                                Image("driveW")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                                Text(ventuorViewModel.ventuorData?.distance ?? "")
                                    .foregroundColor(.ventuorGray)
                                    .font(.footnote)
                                    .padding(.bottom, -8)
                            }
                            .frame(width: 73, height: 70)
                            .background(Color.ventuorBlue)
                            .cornerRadius(10)
 
                        if ventuorViewModel.ventuorData?.parking != "" {
                                Button(action: {
                                    showParkingSheet = true
                                }, label: {
                                    VentuorNavButtonView(imageName: "parkW", buttonText: "PARK")
                                    .sheet(isPresented: $showParkingSheet) {
                                        VentuorGenericSheet(title: "Parking", html: Utils().webMetaViewPort + (ventuorViewModel.ventuorData?.parking ?? ""))
                                            .presentationDetents([.height(400), .medium, .large])
                                            .presentationDragIndicator(.automatic)
                                    }
                                })
                            }
                        
                        if ventuorViewModel.ventuorData?.doorStep != "" {
                                Button(action: {
                                    showDoorStepSheet = true
                                }, label: {
                                    VentuorNavButtonView(imageName: "walkW", buttonText: "DOOR")
                                    .sheet(isPresented: $showDoorStepSheet) {
                                        VentuorGenericSheet(title: "Door Step", html: Utils().webMetaViewPort + (ventuorViewModel.ventuorData?.doorStep ?? ""))
                                            .presentationDetents([.height(400), .medium, .large])
                                            .presentationDragIndicator(.automatic)
                                    }
                                })
                            }
                                
                        Spacer()
                    }
                    .padding(.leading, 18)

                    HStack() {
                        Text(ventuorViewModel.ventuorData?.address ?? "")
                            .padding(5)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, minHeight: 70, alignment: .bottomTrailing)
                    .background(Color("ventuor-orange"))
                    .zIndex(-1)
                    .padding(.top, -50)
                    .shadow(radius: 5)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack(spacing: 20) {
                        Image("call")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)

                        let phone = "Call:  " + (ventuorViewModel.ventuorData?.countrycode ?? "") + " " + (ventuorViewModel.ventuorData?.phone ?? "")
                        Text(phone)
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
                    // .border(width: 1, edges: [.top, .bottom], color: .ventuorGray)
                    .border(width: 1, edges: [.bottom], color: .ventuorGray)

                    Button(action: {
                        showHoursSheet = true
                    }, label: {
                        HStack(spacing: 20) {
                            Image("open")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            
                            VStack(alignment: .leading) {
                                Text("Hours")
                                Text(ventuorViewModel.ventuorData?.hoursSplMsg ?? "")
                                    .fontWeight(.medium)
                                    .font(.caption)
                                    .foregroundColor(.ventuorOpenGreen)
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
                        // .border(width: 1, edges: [.top, .bottom], color: .ventuorGray)
                        .border(width: 1, edges: [.bottom], color: .ventuorGray)
                        .sheet(isPresented: $showHoursSheet) {
                            VentuorHours(hoursHtml: ventuorViewModel.ventuorData?.hours ?? "")
                                .presentationDetents([.height(500), .medium, .large])
                                .presentationDragIndicator(.automatic)
                        }
                    })

                    HStack(spacing: 20) {
                        Image(systemName: "bitcoinsign.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.ventuorBlue)

                        VStack(alignment: .leading) {
                            Text(ventuorViewModel.ventuorData?.payments ?? "Bitcoin, cash, VISA, MasterCard")
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
    //                .border(width: 1, edges: [.top, .bottom], color: .ventuorGray)
                    .border(width: 1, edges: [.bottom], color: .ventuorGray)

                }
                
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        VentuorSaveFollowButtons(imageName: "save", buttonText: "SAVE", selected: false)
                        Spacer()
                        VentuorSaveFollowButtons(imageName: "check-in", buttonText: "CHECK-IN", selected: false)
                        Spacer()
                        VentuorSaveFollowButtons(imageName: "follow", buttonText: "FOLLOW", selected: false)
                        Spacer()
                        VentuorSaveFollowButtons(imageName: "share", buttonText: "SHARE", selected: false)
                    }
                    .padding([.leading, .trailing], 13)
                }

                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center) {
                        HStack(spacing: 20) {
                            Image("browse")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.ventuorBlue)

                            VStack(alignment: .leading, spacing: 0) {
                                Text("website")
                                    .fontWeight(.light)
                                    .font(.caption)
                                    .foregroundColor(.ventuorBlue)
                                    .opacity(0.6)
                                Text(ventuorViewModel.ventuorData?.webSiteUrl ?? "")
                                    .fontWeight(.light)
                                    .font(.system(size: 15))
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
        //                .border(width: 1, edges: [.top, .bottom], color: .ventuorGray)
                        .border(width: 1, edges: [.bottom], color: .ventuorGray)
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
            }
        }

    }
}

#Preview {
    VentuorView()
}
