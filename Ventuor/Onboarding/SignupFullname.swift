//
//  SignupFullname.swift
//  LoginAndAuthentication
//
//  Created by H Sam Dean on 12/31/23.
//

import SwiftUI

struct SignupFullname: View {
    var navFromLandingScreen: Bool
    @State private var goodToAdvance: Bool = false
    @State private var fullname: String = ""
    @Environment(\.dismiss) var dismiss

    @ObservedObject var signupViewModel: SignupViewModel = SignupViewModel()

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
                    Text("What's your name?")
                        .font(.title2)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Enter your full name", text: $signupViewModel.fullname)
                        .font(.callout)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                }
                .padding(.horizontal)
                .padding(.top, 12)

                Button(
                    action: {
                        print("Button for Fullname page")
                        goodToAdvance = true
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
                
                if navFromLandingScreen {
                    NavigationLink {
                        LoginView(navFromLandingScreen: false)
                            //.navigationBarBackButtonHidden(false)
                    } label: {
                        HStack(spacing: 5) {
                            Text("Already have an account?")
                            Text("Login...")
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
                            Text("Already have an account?")
                            Text("Login...")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .font(.system(size: 16))
                        .foregroundColor(.ventuorBlue)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $goodToAdvance, destination: {
            SignupEmail(signupViewModel: signupViewModel)
        })
    }
}

#Preview {
    SignupFullname(navFromLandingScreen: true)
}
