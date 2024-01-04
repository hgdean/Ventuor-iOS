//
//  HomeViewModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import Foundation

class HomeViewModel: ObservableObject {

    func logout() {
        Auth.shared.logout()
    }
}
