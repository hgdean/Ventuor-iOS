//
//  LogoffLink2.swift
//  Ventuor
//
//  Created by Sam Dean on 2/12/24.
//

import SwiftUI

struct LogoffLink2: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var showingOptions = false

    var body: some View {
        HStack(spacing: 20) {
            Menu {
                Button("Confirm logoff", action: logoff)
                Button("Cancel", action: cancelAction)
            } label: {
                VStack(alignment: .leading) {
                    Label("Logoff", systemImage: "square.and.arrow.up.trianglebadge.exclamationmark")
                        .foregroundColor(.ventuorClosedRed)
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
        }
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 15)
        .border(width: 1, edges: [.bottom], color: .ventuorGray)
    }
    func logoff() {
        viewModel.logout()
    }
    func cancelAction() {
    }
}

#Preview {
    LogoffLink2()
}
