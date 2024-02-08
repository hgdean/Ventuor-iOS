//
//  LoginResponse.swift
//  LoginAndAuthentication
//
//  Created by H Sam Dean on 12/26/23.
//

import Foundation

struct ServerResponseError: Codable {
    var errorMessage: String
}
struct ServerResponseResult: Codable {
    var resultCode: Int
    var resultMessage: String?
}
struct LoginResponseResult: Codable {
    var authenticationToken: String
    var userKey: String
    var userRole: String
    var resultCode: Int
    var resultMessage: String?
}
struct LoginResponse: Codable {
    var result: LoginResponseResult?
    var error: ServerResponseError?
}


struct SignupEmailCheckResponseResult: Codable {
    var resultCode: Int
    var resultMessage: String?
}
struct SignupEmailCheckResponse: Codable {
    var result: SignupEmailCheckResponseResult?
    var error: ServerResponseError?
}


struct PhoneAndEmailServiceResponseResult: Codable {
    // EmailServiceResponseResult // PhoneServiceResponseResult
    var email: String?
    var phone: String?
    var resultCode: Int
    var resultMessage: String?
}
struct PhoneAndEmailServerResponse: Codable {
    var result: PhoneAndEmailServiceResponseResult?
    var error: ServerResponseError?
}
