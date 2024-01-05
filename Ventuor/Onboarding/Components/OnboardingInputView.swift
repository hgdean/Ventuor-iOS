//
//  InputView.swift
//  SwiftAPICalls
//
//  Created by H Sam Dean on 12/24/23.
//

import SwiftUI

struct OnboardingInputView: View {
    @Binding var text: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            if isSecureField {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            
            Divider()
        }
    }
}

#Preview {
    OnboardingInputView(text: .constant(""), placeholder: "something@example.com")
}
