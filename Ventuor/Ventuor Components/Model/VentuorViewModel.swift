//
//  VentuorViewModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/11/24.
//

import Foundation

enum ErrorVentuorState: LocalizedError {
    case LIVE
    case OFFLINE
    case DELETED
    case MODIFIED
    case NOPUBLISH
    case NULL

    var rawValue: String {
        switch self {
        case .LIVE:
            return "LIVE"
        case .OFFLINE:
            return "OFFLINE"
        case .DELETED:
            return "DELETED"
        case .MODIFIED:
            return "MODIFIED"
        case .NOPUBLISH:
            return "NOPUBLISH"
        case .NULL:
            return "NULL"
        }
    }
    
    var errorDescription: String? {
        switch self {
        default:
            return ""
        }
    }
    var recoverySuggestion: String? {
        switch self {
        case .LIVE:
            return ""
        case .OFFLINE:
            return "The Ventuor you are trying to view is currently offline."
        case .DELETED:
            return "The Ventuor you are trying to view is no longer available."
        case .MODIFIED:
            return "MODIFIED"
        case .NOPUBLISH:
            return "NOPUBLISH"
        case .NULL:
            return ""
        }
    }
}

class VentuorViewModel: ObservableObject {
    
    var ventuorKey: String = ""
    @Published var ventuor: Ventuor? = nil
    
    static var sample = VentuorViewModel()
    
    @Published var ventuorStateLive: Bool = false
    @Published var errorVentuorState: Swift.Error?

    func whichState(item: String) -> ErrorVentuorState {
        switch item {
        case "LIVE":
            return ErrorVentuorState.LIVE
        case "OFFLINE":
            return ErrorVentuorState.OFFLINE
        case "DELETED":
            return ErrorVentuorState.DELETED
        case "MODIFIED":
            return ErrorVentuorState.MODIFIED
        case "NOPUBLISH":
            return ErrorVentuorState.NOPUBLISH
        default:
            return ErrorVentuorState.NULL
        }
    }
    
    func getVentuorState(ventuorKey: String) {
        self.ventuorKey = ventuorKey
        let services = Services(baseURL: API.baseURL + "/mobile/getVentuorState")
        services.getVentuorState(ventuorKey, cb: cbGetVentuorState)
    }

    fileprivate func cbGetVentuorState(data: Data?, error: NSError?) -> Void {
        print(String(data: data!, encoding: .utf8)!)

        do {
            let response = try JSONDecoder().decode(VentuorState.self, from: data!)
            print(response)
            
            if response.result?.resultMessage != ErrorVentuorState.LIVE.rawValue {
                errorVentuorState = whichState(item: "OFFLINE")
            } else {
                ventuorStateLive = true
                getVentuorData()
            }
        } catch {
        }
    }
    
    func getVentuorData() {
        ventuor?.result?.ventuor = nil
        let services = Services(baseURL: API.baseURL + "/mobile/getVentuor")
        services.getUserProfile(cbGetUserProfile)
        services.getVentuorData(ventuorKey: ventuorKey, cb: cb)
    }
    fileprivate func cbGetUserProfile(_ data: Data?, error: NSError?) -> Void {
        print(String(data: data!, encoding: .utf8)!)
    }
    fileprivate func cb(_ data: Data?, error: NSError?) -> Void {
        
        print(String(data: data!, encoding: .utf8)!)
        
        do {
            let response = try JSONDecoder().decode(Ventuor.self, from: data!)
            print(response)

            ventuor = response
        } catch {
        }
    }
    
    func saveVentuor(ventuorKey: String, title: String, subtitle1: String, iconLocation: String) {
        let services = Services(baseURL: API.baseURL + "/mobile/saveVentuor")
        services.saveVentuor(ventuorKey, title: title, subtitle1: subtitle1, iconLocation: iconLocation, cb: cbSaveVentuor)
    }
    
    fileprivate func cbSaveVentuor(_ data: Data?, error: NSError?) -> Void {
        
        print(String(data: data!, encoding: .utf8)!)
    }
    
    func unsaveVentuor(ventuorKey: String) {
        let services = Services(baseURL: API.baseURL + "/mobile/unSaveVentuor")
        services.unSaveVentuor(ventuorKey, cb: cbUnsaveVentuor)
    }
    
    fileprivate func cbUnsaveVentuor(_ data: Data?, error: NSError?) -> Void {
        
        print(String(data: data!, encoding: .utf8)!)
    }
    
    func followVentuor(ventuorKey: String, title: String, subtitle1: String, iconLocation: String) {
        let services = Services(baseURL: API.baseURL + "/mobile/followVentuor")
        services.followVentuor(ventuorKey, title: title, subtitle1: subtitle1, iconLocation: iconLocation, cb: cbFollowVentuor)
    }
    
    fileprivate func cbFollowVentuor(_ data: Data?, error: NSError?) -> Void {
        
        print(String(data: data!, encoding: .utf8)!)
    }
    
    func unFollowVentuor(ventuorKey: String, title: String, subtitle1: String, iconLocation: String) {
        let services = Services(baseURL: API.baseURL + "/mobile/unFollowVentuor")
        services.unFollowVentuor(ventuorKey, cb: cbunFollowVentuor)
    }
    
    fileprivate func cbunFollowVentuor(_ data: Data?, error: NSError?) -> Void {
        
        print(String(data: data!, encoding: .utf8)!)
    }
}
