//
//  Services.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import Foundation
import CoreLocation

class Services : Web {

    override init(baseURL: String) {
        super.init(baseURL: baseURL)
    }
    
    func login(_ userName: String, password: String, cb: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        
        self.authToken = ""

        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let jsonForLogin: [String: Any] = [
            "requestName": "mobileLogin",
            "requestParam":
            [
                "userName": userName.trimmingCharacters(in: CharacterSet.whitespaces),
                "password": password
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonForLogin, options: [])

        self.post("/mobile/mobileLogin", data: jsonData, cb: cb)
    }

    func mobileFindEmailExists(_ email: String, cb: @escaping (_ data: Data?, _ error: NSError?) -> Void)
    {
        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "mobileFindPhoneExists",
            "requestParam":
            [
                "email": email
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        func postCallback(_ data: Data?, error: NSError?) {
            cb(data, error)
        }

        self.post("/mobile/mobileFindEmailExists", data: jsonData, cb: postCallback)
    }

    func sendEmailForSignUp(_ email: String, phone: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {

        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "confirmEmail",
            "requestParam":
            [
                "email": email,
                "phone": phone
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])

        self.post("/mobile/mobileSendEmailForSignUp", data: jsonData, cb: cb)
    }

    func mobileValidateAndEmailSignUpVentuorMobileUser(_ email: String, fullName: String, password: String, userCode: String, cb: @escaping (_ data: Data?, _ error: NSError?) -> Void)
    {
        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "mobileValidateAndEmailSignUpVentuorMobileUser",
            "requestParam":
            [
                "email": email,
                "fullname": fullName,
                "password": password,
                "userCode": userCode
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])

        self.post("/mobile/mobileValidateAndEmailSignUpVentuorMobileUser", data: jsonData, cb: cb)
    }

}
