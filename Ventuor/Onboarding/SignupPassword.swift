//
//  SignupFullname.swift
//  LoginAndAuthentication
//
//  Created by H Sam Dean on 12/31/23.
//

import SwiftUI

struct SignupPassword: View {
    @ObservedObject var signupViewModel: SignupViewModel
    @State private var goodToAdvance: Bool = false

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
                    Text("Create a password.")
                        .font(.title2)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    OnboardingInputView(text: $signupViewModel.password, placeholder: "Enter a new password")
                        .font(.callout)
                        .autocapitalization(.none)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button(
                    action: {
                        print("Button for Password page")
                        goodToAdvance = true
                        signupViewModel.validateSignup()
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
        .navigationDestination(isPresented: $goodToAdvance, destination: {
            SignupConfirmation(signupViewModel: signupViewModel)
        })
    }
}

#Preview {
    SignupPassword(signupViewModel: SignupViewModel.sample)
}
