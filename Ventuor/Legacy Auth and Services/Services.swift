//
//  Services.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import Foundation
import CoreLocation
import UIKit

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
    
    func getUserProfile(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let userKey: String = Auth.shared.getUserKey() ?? ""
        let json: [String: Any] = [
            "requestName": "getProfile",
            "requestParam":
                [
                    "userKey": userKey
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/getProfile", data: jsonData, cb: cb)
    }
    
    func getVentuorState(_ ventuorKey: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let json: [String: Any] = [
            "requestName": "getVentuorState",
            "requestParam": [
                "ventuorKey": ventuorKey
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/getVentuorState", data: jsonData, cb: cb)
    }
    
    func getVentuorData(ventuorKey: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let lastUpdatedLocation = CLLocationCoordinate2D()
        let lat = lastUpdatedLocation.latitude
        let long = lastUpdatedLocation.longitude
        
        let date = Date()
        
        let isMiles = SettingsInfo.distanceInMiles
        
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
    
    func getVentuorLogoByVentuorKey(_ ventuorKey: String, liveMode: Bool, cb: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "getVentuorLogoByVentuorKey",
            "requestParam":
                [
                    "ventuorKey": ventuorKey,
                    "liveMode": liveMode
                ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        self.post("/mobile/getVentuorLogoByVentuorKey", data: jsonData, cb: cb)
    }
    
    func getMobileVentuorPhoto(_ ventuorKey: String, liveMode: Bool, imageLocation: String, imageType: String,
                               cb: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "getMobileVentuorPhoto",
            "requestParam":
                [
                    "ventuorKey": ventuorKey,
                    "imageLocation": imageLocation,
                    "imageType": imageType,
                    "liveMode": liveMode
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        self.post("/mobile/getMobileVentuorPhoto", data: jsonData, cb: cb)
    }
    
    func getSearchData(searchCategory: String, searchTerm: String, pageNumber: Int, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let locationDataManager = LocationDataManager()
        let lat = locationDataManager.locationManager.location?.coordinate.latitude ?? 42.5803
        let long = locationDataManager.locationManager.location?.coordinate.longitude ?? -83.0302
        
        let category = searchCategory
        let searchTerm = searchTerm
        
        let isMiles = SettingsInfo.distanceInMiles
        
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
    
    func getMobileNearbyVentuorsList(pageNumber: Int, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let locationDataManager = LocationDataManager()
        let lat = locationDataManager.locationManager.location?.coordinate.latitude ?? 0
        let long = locationDataManager.locationManager.location?.coordinate.longitude ?? 0
        
        let isMiles = SettingsInfo.distanceInMiles
        
        Utils.getLocaleCountryName(latitude: lat, longitude: long) { country in
            let date = Date()
            let userKey: String = Auth.shared.getUserKey() ?? ""
            
            // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
            let json: [String: Any] = [
                "requestName": "getMobileNearbyVentuorsList",
                "requestParam": [
                    "latitude": lat,
                    "longitude": long,
                    "country": country ?? "",
                    "category": "",
                    "searchTerm": "",
                    "userKey": userKey,
                    "maxDistance": 50,
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
            
            self.post("/mobile/getMobileNearbyVentuorsList", data: jsonData, cb: cb)
        }
    }
    
    func getMobileWhatsHereVentuorsList(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let locationDataManager = LocationDataManager()
        let lat = locationDataManager.locationManager.location?.coordinate.latitude ?? 0
        let long = locationDataManager.locationManager.location?.coordinate.longitude ?? 0
        
        let isMiles = SettingsInfo.distanceInMiles

        Utils.getLocaleCountryName(latitude: lat, longitude: long) { country in
            let date = Date()
            let userKey: String = Auth.shared.getUserKey() ?? ""
            let json: [String: Any] = [
                "requestName": "getMobileWhatsHereVentuorsList",
                "requestParam": [
                    "latitude": lat,
                    "longitude": long,
                    "country": country ?? "",
                    "category": "",
                    "searchTerm": "",
                    "userKey": userKey,
                    "maxDistance": 0.02,
                    "isMiles": isMiles,
                    "date": Utils.getCurrentDate(date),
                    "day": Utils.getCurrentDay(date),
                    "time": Utils.getCurrentTime(date)
                ]]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
            
            print(json)
            print(String(data: jsonData!, encoding: .utf8)!)

            self.post("/mobile/getMobileWhatsHereVentuorsList", data: jsonData, cb: cb)
        }
    }
    
    func getYouAreHereVentuor(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let locationDataManager = LocationDataManager()
        let lat = locationDataManager.locationManager.location?.coordinate.latitude ?? 42.5803
        let long = locationDataManager.locationManager.location?.coordinate.longitude ?? -83.0302
        
        let isMiles = SettingsInfo.distanceInMiles

        Utils.getLocaleCountryName(latitude: lat, longitude: long) { country in
            let date = Date()
            let userKey: String = Auth.shared.getUserKey() ?? ""
            
            let json: [String: Any] = [
                "requestName": "getYouAreHereVentuor",
                "requestParam": [
                    "latitude": lat,
                    "longitude": long,
                    "country": country ?? "",
                    "category": "",
                    "searchTerm": "",
                    "userKey": userKey,
                    "maxDistance": 0.02,
                    "isMiles": isMiles,
                    "date": Utils.getCurrentDate(date),
                    "day": Utils.getCurrentDay(date),
                    "time": Utils.getCurrentTime(date)
                ]]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
            
            print(json)
            print(String(data: jsonData!, encoding: .utf8)!)

            self.post("/mobile/getYouAreHereVentuor", data: jsonData, cb: cb)
        }
    }
    
    func getVentuorListInTestMode(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let date = Date()
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "getVentuorListInTestMode",
            "requestParam": [
                "userKey": userKey,
                "date": Utils.getCurrentDate(date),
                "day": Utils.getCurrentDay(date),
                "time": Utils.getCurrentTime(date)
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/getVentuorListInTestMode", data: jsonData, cb: cb)
    }
    
    func getVentuorListInLiveMode(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let date = Date()
        let userKey: String = Auth.shared.getUserKey() ?? ""
        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "getVentuorListInLiveMode",
            "requestParam": [
                "userKey": userKey,
                "date": Utils.getCurrentDate(date),
                "day": Utils.getCurrentDay(date),
                "time": Utils.getCurrentTime(date)
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/getVentuorListInLiveMode", data: jsonData, cb: cb)
    }
    
    func getSavedVentuors(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let userKey: String = Auth.shared.getUserKey() ?? ""
        let json: [String: Any] = [
            "requestName": "getSavedVentuors",
            "requestParam": [
                "userKey": userKey
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/getSavedVentuors", data: jsonData, cb: cb)
    }
    
    func getFollowingVentuors(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let userKey: String = Auth.shared.getUserKey() ?? ""
        let json: [String: Any] = [
            "requestName": "getFollowingVentuors",
            "requestParam": [
                "userKey": userKey
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/getFollowingVentuors", data: jsonData, cb: cb)
    }
    
    func saveVentuor(_ ventuorKey: String, title: String, subtitle1: String, iconLocation: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let userKey: String = Auth.shared.getUserKey() ?? ""
        let json: [String: Any] = [
            "requestName": "saveVentuor",
            "requestParam":
                [
                    "userKey": userKey,
                    "ventuorKey": ventuorKey,
                    "title": title,
                    "subtitle1": subtitle1,
                    "iconLocation": iconLocation
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/saveVentuor", data: jsonData, cb: cb)
    }
    
    func unSaveVentuor(_ ventuorKey: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "unSaveVentuor",
            "requestParam":
                [
                    "userKey": userKey,
                    "ventuorKey": ventuorKey
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/unSaveVentuor", data: jsonData, cb: cb)
    }
    
    func isUserSavedVentuor(_ ventuorKey: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "isUserSavedVentuor",
            "requestParam":
                [
                    "userKey": userKey,
                    "ventuorKey": ventuorKey
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/isUserSavedVentuor", data: jsonData, cb: cb)
    }
    
    func followVentuor(_ ventuorKey: String, title: String, subtitle1: String, iconLocation: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "followVentuor",
            "requestParam":
                [
                    "userKey": userKey,
                    "ventuorKey": ventuorKey,
                    "title": title,
                    "subtitle1": subtitle1,
                    "iconLocation": iconLocation
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/followVentuor", data: jsonData, cb: cb)
    }
    
    func unFollowVentuor(_ ventuorKey: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "unFollowVentuor",
            "requestParam":
                [
                    "userKey": userKey,
                    "ventuorKey": ventuorKey
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/unFollowVentuor", data: jsonData, cb: cb)
    }
    
    func isUserFollowingVentuor(_ ventuorKey: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "isUserFollowingVentuor",
            "requestParam":
                [
                    "userKey": userKey,
                    "ventuorKey": ventuorKey
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/isUserFollowingVentuor", data: jsonData, cb: cb)
    }
    
    func saveProfileFullName(_ fullname: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "saveProfileFullName",
            "requestParam":
                [
                    "userKey": userKey,
                    "fullName": fullname
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/saveProfileFullName", data: jsonData, cb: cb)
    }
    
    func saveProfileEmail(_ email: String, confirmCode: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "saveProfileEmail",
            "requestParam":
                [
                    "userKey": userKey,
                    "email": email,
                    "confirmCode": confirmCode
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/saveProfileEmail", data: jsonData, cb: cb)
    }
    
    func saveProfileUsername(_ username: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "saveProfileUsername",
            "requestParam":
                [
                    "userKey": userKey,
                    "username": username
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/saveProfileUsername", data: jsonData, cb: cb)
    }
    
    func savePassword(username: String, newPassword: String, password: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "savePassword",
            "requestParam":
                [
                    "userKey": userKey,
                    "userName": username,
                    "currentPassword": password,
                    "newPassword": newPassword
                ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)

        self.post("/mobile/savePassword", data: jsonData, cb: cb)
    }
 
    func getPhotoForPhotoSettings(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "getPhotoForPhotoSettings",
            "requestParam":
                [
                    "userKey": userKey
            ]
            ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)

        self.post("/mobile/getProfilePhotoForSettings", data: jsonData, cb: cb)
    }

    func saveProfilePhoto(_ base64String: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = Auth.shared.getAccessToken() ?? ""
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        let json: [String: Any] = [
            "requestName": "saveProfilePhoto",
            "requestParam":
                [
                    "userKey": userKey,
                    "content_type": "image/jpeg",
                    "photo": base64String
            ]
            ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        // print(json)
        // print(String(data: jsonData!, encoding: .utf8)!)

        self.post("/mobile/saveProfilePhoto", data: jsonData, cb: cb)
    }

    func sendEmailForPasswordReset(_ userInput: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        let json: [String: Any] = [
            "requestName": "forgotPassword",
            "requestParam":
                [
                    "userInput": userInput
                ]
            ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)

        self.post("/mobile/mobileSendEmailForPassReset", data: jsonData, cb: cb)
    }

    func resetPasswordAndLogin(_ resetCode: String, newPassword: String, username: String, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        
        self.authToken = ""

        let json: [String: Any] = [
            "requestName": "forgotPassword",
            "requestParam":
                [
                    "userInput": username,
                    "password": newPassword,
                    "userCode": resetCode
                    
                ]
            ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)
        
        self.post("/mobile/mobileValidateAndLoginVentuorUser", data: jsonData, cb: cb)
    }

    func getVentuorDataForAdmin(ventuorKey: String, liveMode: Bool, cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        self.authToken = Auth.shared.getAccessToken() ?? ""
        
        let lastUpdatedLocation = CLLocationCoordinate2D()
        let lat = lastUpdatedLocation.latitude
        let long = lastUpdatedLocation.longitude
        
        let date = Date()
        
        let isMiles = SettingsInfo.distanceInMiles
        
        let userKey: String = Auth.shared.getUserKey() ?? ""
        
        // https://stackoverflow.com/questions/70841197/access-data-of-of-struct-swift
        let json: [String: Any] = [
            "requestName": "getVentuorDataForAdmin",
            "requestParam": [
                "latitude": lat,
                "longitude": long,
                "ventuorKey": ventuorKey,
                "userKey": userKey,
                "liveMode": liveMode,
                "date": Utils.getCurrentDate(date),
                "day": Utils.getCurrentDay(date),
                "time": Utils.getCurrentTime(date),
                "isMiles": isMiles
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        print(json)
        print(String(data: jsonData!, encoding: .utf8)!)

        
        self.post("/mobile/getVentuorDataForAdmin", data: jsonData, cb: cb)
    }
    
//    func getCategoriesCellData(_ cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
//
//        self.authToken = Auth.shared.getAccessToken() ?? ""
//
//        let json: [String: Any] = [
//            "requestName": "getCategoriesCellData",
//            "requestParam": Environment().toDictionary()
//            ]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
//        print(json)
//        print(String(data: jsonData!, encoding: .utf8)!)
//
//        self.post("/app/getCategoriesCellData", data: jsonData, cb: cb)
//    }
}
