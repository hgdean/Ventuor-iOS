//
//  SignupFullname.swift
//  LoginAndAuthentication
//
//  Created by H Sam Dean on 12/31/23.
//

import SwiftUI

struct SignupEmail: View {
    @State private var email: String = ""
    @ObservedObject var signupViewModel: SignupViewModel
    
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
                    Text("What's your email?")
                        .font(.title2)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    OnboardingInputView(text: $signupViewModel.email, placeholder: "Enter your email address")
                        .font(.callout)
                        .autocapitalization(.none)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button(
                    action: {
                        print("Button for Email page")
                        signupViewModel.validateEmail()
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
                .padding(.top, 30)
                
                Spacer()
                
            }
        }
        .navigationDestination(isPresented: $signupViewModel.isSignupEmailValid, destination: {
            SignupPassword(signupViewModel: signupViewModel)
        })
    }
    
    func onEmailCheckComplete() {
        
    }
}

#Preview {
    SignupEmail(signupViewModel: SignupViewModel.sample)
}
