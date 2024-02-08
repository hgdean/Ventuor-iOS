//
//  SignupConfirmation.swift
//  LoginAndAuthentication
//
//  Created by H Sam Dean on 1/2/24.
//

import SwiftUI

struct SignupConfirmation: View {
    @ObservedObject var signupViewModel: SignupViewModel

    func login() {
        signupViewModel.validateSignupConfirmationCode()
    }

    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("1000x1000 @ 300 res")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(.vertical, 32)
                
                VStack(spacing: 20) {
                    Text("Signup Confirmation.")
                        .font(.title2)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("We sent you an email confirmation code to verify your account. When you receive it, enter the value here to validate this account.")
                        .font(.footnote)
                        .foregroundColor(.ventuorDarkGray)
                    
                    OnboardingInputView(text: $signupViewModel.confirmationCode, placeholder: "Enter confirmation code")
                        .font(.callout)
                        .autocapitalization(.none)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button(
                    action: {
                        print("Button for Confirmation page")
                        login()
                    },
                    label: {
                        HStack {
                            Text("Validate")
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
                .padding(.top, 30)
                
                Spacer()
            }
            .errorAlert(error: $signupViewModel.error)
            .alert(item: $signupViewModel.message) { message in
                return Alert(
                    title: Text(message.title),
                    message: Text(message.message),
                    dismissButton: .cancel()
                )
            }
        }
    }
}

#Preview {
    SignupConfirmation(signupViewModel: SignupViewModel.sample)
}
