//
//  SearchBarView.swift
//  Ventuor
//
//  Created by Sam Dean on 2/29/24.
//

import SwiftUI

struct SearchBarView: View {
    enum FocusField: Hashable {
      case field
    }
    @FocusState private var focusedField: FocusField?

    @Binding var searchText: String
    var body: some View {
        VStack() {
            VStack() {
                HStack() {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    TextField("Search for a Ventuor", text: $searchText)
                        .foregroundColor(Color.accent)
                        .overlay(
                            Image(systemName: "xmark.circle.fill")
                                .padding()
                                .offset(x: 10)
                                .foregroundColor(Color.accent)
                                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                                .onTapGesture {
                                    searchText = ""
                                }
                            , alignment: .trailing
                        )
                        .focused($focusedField, equals: .field)
                        .task {
                            self.focusedField = .field
                        }

                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.15), radius: 1, x: 0, y:0)
                )
        }
    }
}

#Preview("Content View 1", traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
        .environmentObject(UserProfileModel.shared)
}
#Preview("Content View 2", traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
        .environmentObject(UserProfileModel.shared)
}
