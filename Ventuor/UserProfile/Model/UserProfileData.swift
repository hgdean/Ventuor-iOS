//
//  UserProfileData.swift
//  Ventuor
//
//  Created by Sam Dean on 2/9/24.
//

import Foundation

struct UserProfileData: Codable {
    var result: ServerResponseResult?
    var error: ServerResponseError?
}
struct UserProfileDataResult: Codable {
    var resultCode: Int?
    var resultMessage: String?
    var template: String?
    var ventuor: VentuorData?
}

struct MobilePassResetResponse: Codable {
    var result: MobilePassResetResponseResult?
    var error: ServerResponseError?
}
struct MobilePassResetResponseResult: Codable {
    var resultCode: Int?
    var resultMessage: String?
    var template: String?
    var userInput: String?
    var email: String?
    var phone: String?
    var userName: String?
}
