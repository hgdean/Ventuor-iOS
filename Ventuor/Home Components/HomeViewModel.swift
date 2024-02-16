//
//  HomeViewModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI
import SwiftData

class HomeViewModel: ObservableObject {
    @Published var ventuorList: VentuorList? = nil
    @Published var displayStatusMessage: String? = nil

    @Published var savedVentuors: [SavedFollowingVentuor] = [SavedFollowingVentuor]()
    @Published var followingVentuors: [SavedFollowingVentuor] = [SavedFollowingVentuor]()
    @Published var recentVentuors: [RecentVentuor] = [RecentVentuor]()

    static var sample = HomeViewModel()

    func initialize() {
        ventuorList = nil
        displayStatusMessage = "Loading..."
    }
    
    func prepare() {
        displayStatusMessage = "Rendering..."
    }
    
    func ready(ventuors: [VentuorData]) {
        if ventuorList?.result?.ventuors == nil {
            displayStatusMessage = "No available Ventuors to show"
        } else {
            displayStatusMessage = "Ready"
        }
    }
    
    func jsonDecodeVentuorList(data: Data) {
        do {
            let response = try JSONDecoder().decode(VentuorList.self, from: data)
            print(response)
            
            ventuorList = response
            ready(ventuors: ventuorList?.result?.ventuors ?? [])
        } catch {
            fatalError("Could not decode VentuorList: \(error)")
        }
    }
    
    func getVentuorNearbyList() {
        initialize()
        let services = Services(baseURL: API.baseURL + "/mobile/getMobileNearbyVentuorsList")
        services.getMobileNearbyVentuorsList(pageNumber: 1, cb: cbVentuorList)
    }

    fileprivate func cbVentuorList(_ data: Data?, error: NSError?) -> Void {
        prepare()
        print(String(data: data!, encoding: .utf8)!)
        jsonDecodeVentuorList(data: data!)
    }

    func getAdminVentuorListInTest() {
        initialize()
        let services = Services(baseURL: API.baseURL + "/mobile/getVentuorListInTestMode")
        services.getVentuorListInTestMode(cb: cbVentuorList)
    }

    func getAdminVentuorListInLive() {
        initialize()
        let services = Services(baseURL: API.baseURL + "/mobile/getVentuorListInLiveMode")
        services.getVentuorListInLiveMode(cb: cbVentuorList)
    }

    func getUsersSavedVentuors() {
        initialize()
        let services = Services(baseURL: API.baseURL + "/mobile/getSavedVentuors")
        services.getSavedVentuors(cb: cbSavedVentuorList)
    }
    fileprivate func cbSavedVentuorList(_ data: Data?, error: NSError?) -> Void {
        prepare()
        print(String(data: data!, encoding: .utf8)!)
        do {
            let response = try JSONDecoder().decode(MobileGetSavedVentuorsResponseResult.self, from: data!)
            print(response)
            
            savedVentuors = response.result?.savedVentuors ?? [SavedFollowingVentuor]()
            isReady(ventuors: savedVentuors)
        } catch {
            fatalError("Could not decode MobileGetSavedVentuorsResponseResult: \(error)")
        }
    }

    func getUsersFollowingVentuors() {
        initialize()
        let services = Services(baseURL: API.baseURL + "/mobile/getFollowingVentuors")
        services.getFollowingVentuors(cb: cbFollowingVentuorList)
    }
    fileprivate func cbFollowingVentuorList(_ data: Data?, error: NSError?) -> Void {
        prepare()
        print(String(data: data!, encoding: .utf8)!)
        do {
            let response = try JSONDecoder().decode(MobileGetFollowingVentuorsResponseResult.self, from: data!)
            print(response)
            
            followingVentuors = response.result?.followingVentuors ?? [SavedFollowingVentuor]()
            isReady(ventuors: followingVentuors)
        } catch {
            fatalError("Could not decode MobileGetFollowingVentuorsResponseResult: \(error)")
        }
    }

    func isReady(ventuors: [SavedFollowingVentuor]) {
        if ventuors.isEmpty {
            displayStatusMessage = "No available Ventuors to show"
        } else {
            displayStatusMessage = "Ready"
        }
    }

    func addToRecentVentuor(context: ModelContext, cachedVentuors: [CachedVentuor], cachedVentuor: CachedVentuor) {
        for i in 0..<(cachedVentuors.count) {
            if cachedVentuors[i].ventuorUserKey == Auth.shared.getUserKey()! + ( cachedVentuor.ventuorKey) {
                context.delete(cachedVentuors[i])
            }
        }
        context.insert(cachedVentuor)
    }

    func logout() {
        Auth.shared.logout()
    }
}
