//
//  LogoffLink.swift
//  Ventuor
//
//  Created by Sam Dean on 2/12/24.
//

import SwiftUI

struct LogoffLink: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var showingOptions = false

    var body: some View {
        Button(action: {
            showingOptions = true
        }, label: {
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Button(action: {
                        showingOptions = true
                    }, label: {
                        Label("Logoff", systemImage: "square.and.arrow.up.trianglebadge.exclamationmark")
                            .foregroundColor(.ventuorClosedRed)
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.ventuorBlue)
                    .opacity(0.3)
                    .frame(width: 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 20)
            .padding([.top, .bottom], 15)
            .border(width: 1, edges: [.bottom], color: .ventuorGray)
        })
        .confirmationDialog("Confirm logoff", isPresented: $showingOptions, titleVisibility: .visible) {
            Button(role: .destructive, action: {
                self.logoff()
            }, label: {
                Text("Logoff")
            })
        }
    }
    func logoff() {
        viewModel.logout()
    }
    func cancelAction() {
    }
}

#Preview {
    LogoffLink()
}
