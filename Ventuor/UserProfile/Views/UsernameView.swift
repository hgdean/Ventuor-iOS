//
//  UsernameView.swift
//  Ventuor
//
//  Created by Sam Dean on 2/9/24.
//

import SwiftUI

struct UsernameView: View {
    @State var username: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    enum FocusField: Hashable {
      case field
    }
    @FocusState private var focusedField: FocusField?

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 30) {
                Text("Define your username.")
                    .font(.title2)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Enter your username", text: $username)
                    .autocapitalization(.none)
                    .font(.callout)
                    .padding(.leading, 18)
                    .padding(.trailing, 18)
                    .focused($focusedField, equals: .field)
                    .task {
                        self.focusedField = .field
                    }
            }
            .foregroundColor(Color.ventuorBlue)
            .errorAlert(error: $userProfileModel.error)
            .alert(item: $userProfileModel.message) { message in
                return Alert(
                    title: Text(message.title),
                    message: Text(message.message),
                    dismissButton: .cancel()
                )
            }
            .padding(.horizontal)
            .padding(.top, 50)
            
            VStack(spacing: 12) {
                Button(
                    action: {
                        dismiss()
                    },
                    label: {
                        HStack {
                            Text("Cancel")
                                .fontWeight(.semibold)
                                .padding()
                        }
                        .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                        .foregroundColor(.ventuorBlue)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 13,
                                style: .continuous
                            )
                            .stroke(.ventuorBlue, lineWidth: 2)
                        )
                    }
                )
                
                Button(
                    action: {
                        userProfileModel.username = username
                        userProfileModel.saveUsername()
                    },
                    label: {
                        HStack {
                            Text("Save")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(Color(.white))
                        .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                    }
                )
                .background(Color("ventuor-blue"))
                .cornerRadius(13)
            }
        }
        Spacer()
    }
}

#Preview {
    UsernameView(username: "hgdean")
        .environmentObject(UserProfileModel.shared)
}
