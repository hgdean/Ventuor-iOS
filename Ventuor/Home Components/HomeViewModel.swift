//
//  HomeViewModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var ventuorList: VentuorList? = nil
    @Published var displayStatusMessage: String? = nil

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
        services.getSavedVentuors(cb: cbVentuorList)
    }

    func getUsersFollowingVentuors() {
        initialize()
        let services = Services(baseURL: API.baseURL + "/mobile/getFollowingVentuors")
        services.getFollowingVentuors(cb: cbVentuorList)
    }

    func logout() {
        Auth.shared.logout()
    }
}
