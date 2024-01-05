//
//  LandingView.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI

struct LandingView: View {
    @State private var advanceToLogin: Bool = false
    @State private var goodToAdvance: Bool = false

    init() {
        self._advanceToLogin = State(initialValue: Bool(advanceToLogin))
    }

    var body: some View {
        NavigationStack() {
            VStack {
                // image
                Image("1000x1000 @ 300 res")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(.vertical, 90)
                
                VStack {
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Spacer()
                
                Text("Welcome to Ventuor")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(.ventuorBlue)
                    .padding(.bottom, 80)
                
                NavigationLink {
                    SignupFullname(navFromLandingScreen: true)
                    //.navigationBarBackButtonHidden(false)
                } label: {
                    HStack {
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.width - 160, height: 48)
                }
                .background(Color("ventuor-blue"))
                .cornerRadius(13)

//                Button(
//                    action: {
//                        print("Button for Signup on LandingView page")
//                        setGoodToAdvance(advanceToLogin: false)
//                    },
//                    label: {
//                        HStack {
//                            Text("Sign up")
//                                .fontWeight(.semibold)
//                        }
//                        .foregroundColor(Color(.white))
//                        .frame(width: UIScreen.main.bounds.width - 160, height: 48)
//                    }
//                )
//                .background(Color("ventuor-blue"))
//                .cornerRadius(13)

                NavigationLink {
                    // advanceToLogin.toggle()
                    LoginView(navFromLandingScreen: true)
                    //                        .navigationBarBackButtonHidden(false)
                } label: {
                    HStack {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.ventuorBlue)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.ventuorBlue)
                    }
                    .frame(width: UIScreen.main.bounds.width - 160, height: 48)
                }
                .background(Color("ventuor-gray"))
                .cornerRadius(13)

//                Button(
//                    action: {
//                        print("Button for Login on LandingView page")
//                        setGoodToAdvance(advanceToLogin: true)
//                    },
//                    label: {
//                        HStack {
//                            Text("Login")
//                                .fontWeight(.semibold)
//                                .foregroundColor(.ventuorBlue)
//                            Image(systemName: "arrow.right")
//                                .foregroundColor(.ventuorBlue)
//                        }
//                        .frame(width: UIScreen.main.bounds.width - 160, height: 48)
//                    }
//                )
//                .background(Color("ventuor-gray"))
//                .cornerRadius(13)
            }
        }
    }

    func setGoodToAdvance(advanceToLogin: Bool) {
        self.goodToAdvance = true
        self.advanceToLogin = advanceToLogin
    }
}


#Preview {
    LandingView()
}
