//
//  ResetPassword.swift
//  Ventuor
//
//  Created by Sam Dean on 2/15/24.
//

import SwiftUI

struct ResetPassword: View {

    @State private var emailOrUsername: String = ""
    @EnvironmentObject var userProfileModel: UserProfileModel

    @ObservedObject var viewModel: LoginViewModel

    enum FocusField: Hashable {
      case field
    }
    @FocusState private var focusedField: FocusField?

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 30) {
                Text("Create a new password")
                    .font(.title2)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Enter the reset code from your email and define a new password.")
                    .font(.caption)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 0) {
                    Text(viewModel.emailAddressMasked)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    Divider()
                    OnboardingInputView(text: $viewModel.resetCode, placeholder: "Reset code")
                        .padding(.top, 10)
                        .task {
                            self.focusedField = .field
                        }
                    OnboardingInputView(text: $viewModel.newPassword1, placeholder: "New password", isSecureField: true)
                        .padding(.top, 10)
                    OnboardingInputView(text: $viewModel.newPasswordConfirm, placeholder: "Confirm new password", isSecureField: true)
                        .padding(.top, 10)
                }
                .font(.callout)
                .padding(.leading, 18)
                .padding(.trailing, 18)
            }
            .padding(.horizontal)
            .padding(.top, 50)

            Button(
                action: {
                    viewModel.resetPasswordAndLogin()
                },
                label: {
                    HStack {
                        Text("Reset Password")
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
            .padding(.top, 0)
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
    ResetPassword(viewModel: LoginViewModel.sample)
        .environmentObject(UserProfileModel.shared)
}
