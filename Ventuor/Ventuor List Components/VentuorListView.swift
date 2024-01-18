//
//  VentuorListView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/17/24.
//

import SwiftUI

struct VentuorListView: View {
    @ObservedObject var ventuorListModel: VentuorListModel = VentuorListModel()
    
    init() {
        ventuorListModel.getVentuorListData()
    }
    var body: some View {
            ScrollView() {
                VStack() {
                    let listCount = ventuorListModel.ventuorListData?.count ?? 0
                    ForEach(0..<listCount, id: \.self) { index in
                        NavigationLink {
                            VentuorView(ventuorKey: ventuorListModel.ventuorListData?[index].ventuorKey ?? "")
                            //.navigationBarBackButtonHidden(false)
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {                         // Main header name / info
                                
                                if let timeframeStatusMessage = ventuorListModel.ventuorListData?[index].timeframeStatusMessage {
                                    Text(timeframeStatusMessage)
                                        .foregroundColor(.ventuorEndedRed)
                                        .fontWeight(.bold)
                                        .italic()
                                        .font(.caption)
                                }
                                
                                HStack() {
                                    Image(ventuorListModel.ventuorListData?[index].icon ?? "missing")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .padding(0)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(ventuorListModel.ventuorListData?[index].title ?? "")
                                            .fontWeight(.medium)
                                            .font(.title2)
                                            .padding(0)
                                        Text(ventuorListModel.ventuorListData?[index].subTitle1 ?? "")
                                            .padding(.top, -3)
                                            .padding(.bottom, 2)
                                            .font(.caption)
                                            .fontWeight(.medium)
                                        Text(ventuorListModel.ventuorListData?[index].subTitle2 ?? "")
                                            .fontWeight(.light)
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                            .padding(0)
                                    }
                                    .padding(.leading, 5)
                                    .background(.white)
                                    
                                    Spacer()
                                }
                                
                                VentuorTitleOpenClosedStatus(status: ventuorListModel.ventuorListData?[index].status ?? "", statusMessage: ventuorListModel.ventuorListData?[index].statusMessage ?? "")
                                
                            }
                            .padding(10)
                            .background(.white)
                            .overlay(alignment: .topTrailing, content: {
                                Image(.ventuorBannerNew)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                            })
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                    }
                    .padding([.bottom, .top], 5)
                }
            }
            .padding(15)
            
        .background(Color("ventuor-light-gray"))
    }
}

#Preview {
    VentuorListView()
}
