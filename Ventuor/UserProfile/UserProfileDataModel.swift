//
//  UserProfileDataModel.swift
//  Ventuor
//
//  Created by Sam Dean on 2/10/24.
//

import SwiftUI
import SwiftData

@Model
class UserProfileDataModel {
    
    @Attribute(.unique) var userKey: String = ""
    
    var username: String = ""
    var fullname: String = ""
    var countrycode: String = ""
    var phone: String = ""
    var email: String = ""
    var profilePhoto: String = ""
    var profilePhotoName: String = ""
    var profilePhotoType: String = ""
    
    var roles = [String]()
    var lastModified: String = ""
    
    // var homeAddress: Address = Address()
    // var workAddress: Address = Address()
    
    var recentVentuors: [RecentVentuor] = [RecentVentuor]()
    
    init(userKey: String, username: String, fullname: String, countrycode: String, phone: String, email: String, profilePhoto: String, profilePhotoName: String, profilePhotoType: String, roles: [String] = [String](), lastModified: String) {
        self.userKey = userKey
        self.username = username
        self.fullname = fullname
        self.countrycode = countrycode
        self.phone = phone
        self.email = email
        self.profilePhoto = profilePhoto
        self.profilePhotoName = profilePhotoName
        self.profilePhotoType = profilePhotoType
        self.roles = roles
        self.lastModified = lastModified
        // self.homeAddress = homeAddress
        // self.workAddress = workAddress
    }
    
    init(data: UserProfileDetailsVO) {
        self.userKey = data.userKey ?? ""
        self.username = data.userName ?? ""
        self.fullname = data.fullname ?? ""
        self.countrycode = data.countrycode ?? ""
        self.phone = data.phone ?? ""
        self.email = data.email ?? ""
        self.profilePhoto = data.profilePhoto ?? ""
        self.profilePhotoName = data.profilePhotoName ?? ""
        self.profilePhotoType = data.profilePhotoType ?? ""
        self.roles = data.roles ?? []
        self.lastModified = data.lastModified ?? ""
        
        // self.homeAddress = Address(data: data.homeAddress ?? UserAddressVO())
        // self.workAddress = Address(data: data.workAddress ?? UserAddressVO())
    }
    
    func addRecentVentuor(userKey: String, ventuorKey: String, title: String, subTitle1: String) {
        recentVentuors.append(RecentVentuor(userKey: userKey, ventuorKey: ventuorKey, title: title, subTitle1: subTitle1))
        for i in 0..<(recentVentuors.count) {
            print(recentVentuors[i])
        }
    }
    func addRecentVentuor(recentVentuor: RecentVentuor) {
        recentVentuors.append(recentVentuor)
        for i in 0..<(recentVentuors.count) {
            print(recentVentuors[i])
        }
    }
    func removeRecentVentuor(ventuorUserKey: String) {
        for i in 0..<(recentVentuors.count) {
            if recentVentuors[i].ventuorUserKey == ventuorUserKey {
                recentVentuors.remove(at: i)
                return
            }
        }
    }
}

final class RecentVentuor: Codable, Identifiable {
    
    var ventuorUserKey: String
    var userKey: String
    var ventuorKey: String
    var title: String
    var subTitle1: String
    var updated: Date

    // var userProfile: UserProfileDataModel? = nil

    init(userKey: String, ventuorKey: String, title: String, subTitle1: String) {
        self.ventuorUserKey = userKey + ventuorKey
        self.userKey = userKey
        self.ventuorKey = ventuorKey
        self.title = title
        self.subTitle1 = subTitle1
        self.updated = .now
    }
}

//    struct Address: Codable {
//        var userKey: String = ""
//        var streetAddress: String = ""
//        var city: String = ""
//        var state: String = ""
//        var zipcode: String = ""
//        var country: String = ""
//
//        // var userProfile: UserProfileDataModel? = nil
//
//        init(userKey: String = "", streetAddress: String = "", city: String = "", state: String = "", zipcode: String = "", country: String = "") {
//            self.userKey = userKey
//            self.streetAddress = streetAddress
//            self.city = city
//            self.state = state
//            self.zipcode = zipcode
//            self.country = country
//        }
//
//        init(data: UserAddressVO) {
//            self.userKey = data.userKey ?? ""
//            self.streetAddress = data.streetAddress ?? ""
//            self.city = data.city ?? ""
//            self.state = data.state ?? ""
//            self.zipcode = data.zipcode ?? ""
//            self.country = data.country ?? ""
//        }
//
//        init(data: Address) {
//            self.userKey = data.userKey
//            self.streetAddress = data.streetAddress
//            self.city = data.city
//            self.state = data.state
//            self.zipcode = data.zipcode
//            self.country = data.country
//        }
//    }

