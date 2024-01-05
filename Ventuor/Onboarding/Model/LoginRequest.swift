//
//  LoginRequest.swift
//  LoginAndAuthentication
//
//  Created by H Sam Dean on 12/26/23.
//

import Foundation

struct RequestParam: Encodable {
    let userName: String
    let password: String
}
struct LoginRequest: Encodable {
    let requestName: String
    let requestParam: RequestParam
}
