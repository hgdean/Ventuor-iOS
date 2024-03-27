//
//  StartViewPage.swift
//  Ventuor
//
//  Created by Sam Dean on 3/19/24.
//

import SwiftUI

struct StartViewPage: View {
    @Binding var showAdminStartPage: Bool
    private let dotAppearance = UIPageControl.appearance()

    @State var currentIndex: Int = 0

    var body: some View {
        VStack {
            
            VStack(spacing: 15) {
                Image(systemName: "pencil.and.outline")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(Color("ventuor-blue"))

                Text("Administration")
                    .foregroundColor(Color("ventuor-blue"))
                    .font(.title2.bold())
                
                Text("Become a Ventuor Creator")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.ventuorOrange)
                    .opacity(1)
                
                Button(
                    action: {
                    },
                    label: {
                        HStack {
                            Text("Sign Up  ->")
                                .fontWeight(.semibold)
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                        }
                        .foregroundColor(Color(.white))
                    }
                )
                .background(Color("ventuor-blue"))
                .cornerRadius(23)
                .opacity(0.4)

                Text("Coming Soon")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
            }
            
        }
    }
        
}

#Preview {
    StartViewPage(showAdminStartPage: .constant(true))
}

