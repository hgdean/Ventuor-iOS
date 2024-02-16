//
//  LoginView.swift
//  LoginAndAuthentication
//
//  Created by H Sam Dean on 12/30/23.
//

import SwiftUI

struct LoginView: View {
    var navFromLandingScreen: Bool
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss

    // @State private var needHelpLoggingIn = false
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()

    func login() {
        viewModel.login()
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // image
                Image("1000x1000 @ 300 res")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(.vertical, 32)

                VStack(spacing: 35) {
                    Text("Login")
                        .font(.title)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 0) {
                        OnboardingInputView(text: $viewModel.userName, placeholder: "Enter email, username, or phone")
                            .font(.callout)
                            .autocapitalization(.none)
                            .padding(.leading, 18)
                            .padding(.trailing, 18)

                        OnboardingInputView(text: $viewModel.password, placeholder: "Enter your password", isSecureField: true)
                            .font(.callout)
                            .padding(.leading, 18)
                            .padding(.trailing, 18)
                            .padding(.top, 10)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button(
                    action: login,
                    label: {
                        HStack {
                            Text("Login")
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
                
                Button {
                    viewModel.showUsernameOrEmailPage.toggle()
                } label: {
                    Text("Need help logging in?")
                        .padding(.top, 20)
                        .foregroundColor(.ventuorBlue)
                }
                
                Spacer()
                
                if navFromLandingScreen {
                    NavigationLink {
                        SignupFullname(navFromLandingScreen: false)
                    } label: {
                        HStack(spacing: 5) {
                            Text("Don't have an account yet?")
                            Text("Sign up...")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .font(.system(size: 16))
                        .foregroundColor(.ventuorBlue)
                    }
                } else {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Text("Don't have an account yet?")
                            Text("Sign up...")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .font(.system(size: 16))
                        .foregroundColor(.ventuorBlue)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showUsernameOrEmailPage, content: {
                RequestPasswordReset(viewModel: viewModel)
                    .presentationDetents([.height(450)])
                    .presentationDragIndicator(.visible)

            })
            .sheet(isPresented: $viewModel.showPasswordResetPage, content: {
                ResetPassword(viewModel: viewModel)
                    .presentationDetents([.height(450)])
                    .presentationDragIndicator(.visible)

            })
        }
    }
}

#Preview {
    LoginView(navFromLandingScreen: true)
}
