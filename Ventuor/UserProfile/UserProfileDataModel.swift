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
    
    var savedVentuors: [SaveFollowVentuor] = [SaveFollowVentuor]()
    var followingVentuors: [SaveFollowVentuor] = [SaveFollowVentuor]()

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
    
    func setSavedVentuors(data: [SaveFollowVentuor]) {
        self.savedVentuors = data
    }
    func setFollowingVentuors(data: [SaveFollowVentuor]) {
        self.followingVentuors = data
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

