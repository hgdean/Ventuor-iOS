//
//  VentuorHours.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/11/24.
//

import SwiftUI

struct VentuorHoursSheet: View {
    
    @State var text = "<!doctype html><html><meta name = 'viewport' content = 'width=device-width, initial-scale=1.0'><head><title>DynamicWebViewCell</title><style>  html { -webkit-text-size-adjust: 100%; /* Prevent font scaling in landscape while allowing user zoom */}  body {     font-family: Helvetica Neue; color: #243046;  font-size: 11pt;  margin: 14px;    font-weight: 400;    }  .day {  float: left;  margin: 0;   }   .status {float: right;  margin: 0;  }div.clear { clear: both;  }  div.spec {  text-overflow: ellipsis; overflow: visible;  white-space: nowrap;  text-align: left; }  div.header { text-overflow: ellipsis;  overflow: visible; white-space: nowrap;  text-align: center;  /*margin-top: 50px; */  background-color: #eeeeee;   font-weight: 600; font-style: italic; padding: 6px 0; margin-bottom: 8px}   p.reg {   margin: 0;  }  .open {color: #000;font-weight: 500;  } .closed {color: #B3230C;font-weight: 500;  }  .message {color: #888888;font-style: italic;margin-bottom: 15px;  }</style></head><body><div class=\"header clear\"><p class=\"reg\">Special Hours</p></div><div class=\"clear\"> <p class=\"day\">Monday, September 5, 2016</p><p class=\"status open\">10:00 AM - 9:00 PM</p></div><div class=\"clear\"> <p class=\"day message\">Open Labor Day Holiday</p></div><div class=\"header clear\"><p class=\"reg\">Regular Hours of Operation</p></div><div class=\"clear\"><p class=\"day\">Sunday</p><p class=\"status\">12:00 PM - 6:00 PM</p></div><div class=\"clear\"><p class=\"day\">Monday</p><p class=\"status\">10:00 AM - 9:00 PM</p></div><div class=\"clear\"><p class=\"day\">Tuesday</p><p class=\"status\">10:00 AM - 9:00 PM</p></div><div class=\"clear\"><p class=\"day\">Wednesday</p><p class=\"status\">10:00 AM - 9:00 PM</p></div><div class=\"clear\"><p class=\"day\">Thursday</p><p class=\"status\">10:00 AM - 9:00 PM</p></div><div class=\"clear\"><p class=\"day\">Friday</p><p class=\"status\">10:00 AM - 9:00 PM</p></div><div class=\"clear\"><p class=\"day\">Saturday</p><p class=\"status\">10:00 AM - 9:00 PM</p></div><br></body></html>"
    
    var title: String
    @State var hoursHtml: String
    @StateObject var locationDataManager = LocationDataManager()

    var body: some View {
        HStack() {
            Spacer()
            Text(title)
            Spacer()
        }
        .font(.title3)
        .foregroundColor(Color.white)
        .frame(height: 60)
        .background(Color.ventuorBlue)
        .ignoresSafeArea()

        HTMLRender(html: hoursHtml)
            //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 500, maxHeight: .infinity)
            //.padding()
    }
    
//    var body: some View {
//        HStack() {
//            Spacer()
//            Text("Hours")
//            Spacer()
//        }
//        .font(.title3)
//        .foregroundColor(Color.white)
//        .frame(height: 60)
//        .background(Color.ventuorBlue)
//        .ignoresSafeArea()
//        
//        ScrollView() {
//            
//            HStack(spacing: 20) {
//
//                Text("Special Hours")
//                    .font(.callout)
//                    .fontWeight(.medium)
//                    .italic()
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(6)
//                    .background(Color.ventuorGray)
//                
//            }
//            .padding([.leading, .trailing], 15)
//            .padding([.top, .bottom], 8)
//                        
//            VStack(spacing: 15) {
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Monday, January 10, 2024")
//                            .font(.subheadline)
//                        Text("Closed for MLK Day")
//                            .fontWeight(.light)
//                            .font(.subheadline)
//                            .italic()
//                            .foregroundColor(.ventuorBlue)
//                            .opacity(0.6)
//                    }
//
//                    Spacer()
//                    
//                    VStack() {
//                        Text("Closed")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                            .foregroundColor(Color.ventuorEndedRed)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Monday, January 10, 2024")
//                            .font(.subheadline)
//                        Text("Closed for MLK Day")
//                            .fontWeight(.light)
//                            .font(.subheadline)
//                            .italic()
//                            .foregroundColor(.ventuorBlue)
//                            .opacity(0.6)
//                    }
//
//                    Spacer()
//                    
//                    VStack() {
//                        Text("Closed")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                            .foregroundColor(Color.ventuorEndedRed)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//            }
//            
//            HStack(spacing: 20) {
//
//                Text("Regular Hours of Operation")
//                    .font(.callout)
//                    .fontWeight(.medium)
//                    .italic()
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(6)
//                    .background(Color.ventuorGray)
//                
//            }
//            .padding([.leading, .trailing], 15)
//            .padding([.top, .bottom], 8)
//            
//            VStack(spacing: 12) {
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Sunday")
//                            .font(.subheadline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack() {
//                        Text("8:00 AM - 5:00 PM")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Monday")
//                            .font(.subheadline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack() {
//                        Text("Closed")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Tuesday")
//                            .font(.subheadline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack() {
//                        Text("8:00 AM - 5:00 PM")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Wednesday")
//                            .font(.subheadline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack() {
//                        Text("8:00 AM - 5:00 PM")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Thursday")
//                            .font(.subheadline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack() {
//                        Text("8:00 AM - 5:00 PM")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Friday")
//                            .font(.subheadline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack() {
//                        Text("8:00 AM - 5:00 PM")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//                HStack() {
//                    VStack(alignment: .leading) {
//                        Text("Saturday")
//                            .font(.subheadline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack() {
//                        Text("8:00 AM - 5:00 PM")
//                            .fontWeight(.semibold)
//                            .font(.subheadline)
//                    }
//                }
//                .padding([.leading, .trailing], 15)
//
//            }
//            
//            Spacer()
//        }
//        
//    }
}

#Preview {
    VentuorView(ventuorKey: "")
}
