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
struct LoginResponseResult: Codable {
    var authenticationToken: String
    var userKey: String
    var userRole: String
    var resultCode: Int
    var resultMessage: String?
}
struct LoginResponse: Codable {
    var error: ServerResponseError?
    var result: LoginResponseResult?
}
