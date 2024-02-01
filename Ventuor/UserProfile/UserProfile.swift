//
//  UserProfile.swift
//  Ventuor
//
//  Created by Sam Dean on 1/26/24.
//

import Foundation

struct UserProfile: Codable {
    var result: MobileGetProfileResponse?
    var error: ServerResponseError?
}

struct MobileGetProfileResponse: Codable {
    var resultCode: Int?
    var resultMessage: String?
    var profileDetails: UserProfileDetailsVO?
    var followingVentuors: [SaveFollowVentuor]?
    var savedVentuors: [SaveFollowVentuor]?
}

struct UserProfileDetailsVO: Codable {
    var userKey: String?
    var userName: String?
    var fullname: String?
    var countrycode: String?
    var phone: String?
    var email: String?
    var profilePhoto: String?
    var profilePhotoName: String?
    var profilePhotoType: String?
    var homeAddress: UserAddressVO?
    var workAddress: UserAddressVO?
    var lastModified: String?
    var roles: [String]?
}

struct UserAddressVO: Codable {
    var userKey: String?
    var streetAddress: String?
    var city: String?
    var zipcode: String?
    var state: String?
    var country: String?
}

struct SaveFollowVentuor: Codable {
    var icon: String?
    var title: String?
    var subTitle1: String?
    var ventuorKey: String?
}
