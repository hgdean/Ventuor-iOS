//
//  VentuorMapsItem.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/16/24.
//

import SwiftUI
import MapKit

struct VentuorMapsItem: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        Button(action: {
            showingSheet = true
        }, label: {
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
        })
        .actionSheet(isPresented: $showingSheet) {
            let latitude = 45.5088
            let longitude = -73.554
            
            let appleURL = "http://maps.apple.com/?daddr=\(latitude),\(longitude)"
            let googleURL = "comgooglemaps://?daddr=\(latitude),\(longitude)&directionsmode=driving"
            let wazeURL = "waze://?ll=\(latitude),\(longitude)&navigate=false"
            
            let googleItem = ("Google Map", URL(string:googleURL)!)
            let wazeItem = ("Waze", URL(string:wazeURL)!)
            var installedNavigationApps = [("Apple Maps", URL(string:appleURL)!)]
            
            if UIApplication.shared.canOpenURL(googleItem.1) {
                installedNavigationApps.append(googleItem)
            }
            
            if UIApplication.shared.canOpenURL(wazeItem.1) {
                installedNavigationApps.append(wazeItem)
            }
            
            var buttons: [ActionSheet.Button] = []
            for app in installedNavigationApps {
                let button: ActionSheet.Button = .default(Text(app.0)) {
                    UIApplication.shared.open(app.1, options: [:], completionHandler: nil)
                }
                buttons.append(button)
            }
            let cancel: ActionSheet.Button = .cancel()
            buttons.append(cancel)
            
            return ActionSheet(title: Text("Navigate"), message: Text("Select an app..."), buttons: buttons)
        }
    }
}
#Preview {
    VentuorMapsItem()
}
