//
//  RequestPasswordReset.swift
//  Ventuor
//
//  Created by Sam Dean on 2/14/24.
//

import SwiftUI

struct RequestPasswordReset: View {

    @State private var emailOrUsername: String = ""
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    @ObservedObject var viewModel: LoginViewModel

    enum FocusField: Hashable {
      case field
    }
    @FocusState private var focusedField: FocusField?

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 30) {
                Text("Reset your password")
                    .font(.title2)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Enter the email or username of the user associated with this account. We'll send you a reset code that you will need to enter to create a new password.")
                    .font(.caption)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack() {
                    TextField("Enter your email or username", text: $emailOrUsername)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .font(.callout)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                        .focused($focusedField, equals: .field)
                        .task {
                            self.focusedField = .field
                        }
                    Divider()
                        .padding(.leading, 16)
                }
            }
            .padding(.horizontal)
            .padding(.top, 50)
            
            Button(
                action: {
                    viewModel.sendEmailForPasswordReset(userInput: emailOrUsername)
                    viewModel.showPasswordResetPage = true
                },
                label: {
                    HStack {
                        Text("Continue")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                    }
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                }
            )
            .background(Color("ventuor-blue"))
            .cornerRadius(13)
            .padding(.top, 20)
            .errorAlert(error: $viewModel.error)
            .alert(item: $viewModel.message) { message in
                return Alert(
                    title: Text(message.title),
                    message: Text(message.message),
                    dismissButton: .cancel()
                )
            }
        }

        Spacer()
    }
}

#Preview {
    RequestPasswordReset(viewModel: LoginViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
