//
//  SettingsViewTab.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/9/24.
//

import SwiftUI

struct SettingsViewTab: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack() {
            Text("Tab Content Settings")
            
            Button(
                action: viewModel.logout,
                label: {
                    Text("Logout")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(30)
                }
            )
        }
    }
}

#Preview {
    SettingsViewTab()
}
