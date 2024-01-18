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

    func getVentuorData(ventuorKey: String, lat: Double, long: Double, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
//        var lastUpdatedLocation = LocationManager.instance.lastUpdate
//
//        if lastUpdatedLocation == nil
//        {
//            print("getVentuorData() No Location Coordinates!", terminator: "")
            var lastUpdatedLocation = CLLocationCoordinate2D()
            lastUpdatedLocation.latitude = 0
            lastUpdatedLocation.longitude = 0
//        }
        
        let date = Date()
        
        let isMiles = SettingsInfo.isMilesKM == 1
        
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "getVentuor",
            "requestParam": [
                "latitude": lat,
                "longitude": long,
                "ventuorKey": ventuorKey,
                "userKey": userKey,
                "date": Utils.getCurrentDate(date),
                "day": Utils.getCurrentDay(date),
                "time": Utils.getCurrentTime(date),
                "isMiles": isMiles
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])

        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)

        self.post("/mobile/getVentuor", data: jsonData, cb: cb)
    }

    func getSearchData(searchCategory: String, searchTerm: String, lat: Double, long: Double, pageNumber: Int, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""

//        var lastUpdatedLocation = LocationManager.instance.lastUpdate
//        
//        if lastUpdatedLocation == nil
//        {
//            print("getSearchData() No Location Coordinates!", terminator: "")
//            lastUpdatedLocation = CLLocationCoordinate2D()
//            lastUpdatedLocation?.latitude = 0
//            lastUpdatedLocation?.longitude = 0
//        }
        
        let category = searchCategory
        let searchTerm = searchTerm
        
        let isMiles = SettingsInfo.isMilesKM == 1
        
        Utils.getLocaleCountryName(latitude: lat, longitude: long) { country in
            let date = Date()
            let userKey: String = Auth.shared.getUserKey() ?? ""

            // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
            let json: [String: Any] = [
                "requestName": "getVentuorListForSearch",
                "requestParam": [
                    "latitude": lat,
                    "longitude": long,
                    "country": country ?? "",
                    "category": category,
                    "searchTerm": searchTerm,
                    "userKey": userKey,
                    "maxDistance": 25000,
                    "isMiles": isMiles,
                    "date": Utils.getCurrentDate(date),
                    "day": Utils.getCurrentDay(date),
                    "time": Utils.getCurrentTime(date),
                    "pageNumber": pageNumber
                ]
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])

            print(json)
            print(String(data: jsonData!, encoding: .utf8)!)

            self.post("/mobile/getVentuorListForSearch", data: jsonData, cb: cb)
        }
    }
}
