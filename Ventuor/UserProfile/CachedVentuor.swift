//
//  CachedVentuor.swift
//  Ventuor
//
//  Created by Sam Dean on 2/10/24.
//

import SwiftUI
import SwiftData

@Model
final class CachedVentuor {
    
    @Attribute(.unique) var ventuorUserKey: String
    var userKey: String
    var ventuorKey: String
    var title: String
    var subTitle1: String
    var updated: Date

    var userProfile: UserProfileDataModel? = nil

    init(userKey: String, ventuorKey: String, title: String, subTitle1: String) {
        self.ventuorUserKey = userKey + ventuorKey
        self.userKey = userKey
        self.ventuorKey = ventuorKey
        self.title = title
        self.subTitle1 = subTitle1
        self.updated = .now
    }
}
