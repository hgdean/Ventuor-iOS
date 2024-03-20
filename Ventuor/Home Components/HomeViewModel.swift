//
//  HomeViewModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/4/24.
//

import SwiftUI
import SwiftData
import Network

class HomeViewModel: ObservableObject {
    @Published var ventuorList: VentuorList? = nil
    @Published var ventuors: [VentuorData] = [VentuorData]()
    @Published var youAreHereVentuorList: [VentuorData] = [VentuorData]()
    @Published var displayStatusMessage: String = ""

    @Published var isThereSomethingHere: Bool = false
    @Published var youAreHereListReady: Bool = false

    @Published var searchResult: Bool = false

    //@Published var savedVentuors: [SaveFollowVentuor] = [SaveFollowVentuor]()
    //@Published var followingVentuors: [SaveFollowVentuor] = [SaveFollowVentuor]()
    //@Published var recentVentuors: [RecentVentuor] = [RecentVentuor]()

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
            searchResult = true
        }
    }
    
//    func refreshUserProfile(userProfileModel: UserProfileModel) {
//        savedVentuors = userProfileModel.userProfileDataModel?.savedVentuors ?? []
//        followingVentuors = userProfileModel.userProfileDataModel?.followingVentuors ?? []
//    }
    
    func jsonDecodeVentuorList(data: Data) {
        do {
            let response = try JSONDecoder().decode(VentuorList.self, from: data)
            print(response)
            
            ventuors = response.result?.ventuors ?? []
            ventuorList = response
            ready(ventuors: ventuorList?.result?.ventuors ?? [])
        } catch {
            print("Could not decode VentuorList: \(error)")
        }
    }
    
    func getVentuorNearbyList() {
        initialize()
        let services = Services(baseURL: API.baseURL + "/mobile/getMobileNearbyVentuorsList")
        services.getMobileNearbyVentuorsList(pageNumber: 1, cb: cbVentuorList)
    }

    fileprivate func cbVentuorList(_ data: Data?, error: NSError?) -> Void {
        if data != nil {
            prepare()
            print(String(data: data!, encoding: .utf8)!)
            jsonDecodeVentuorList(data: data!)
        } else {
            print("Error: Data is nil. func cbVentuorList()")
        }
    }

    func getYouAreHereVentuorList() {
        let services = Services(baseURL: API.baseURL + "/mobile/getYouAreHereVentuor")
        services.getYouAreHereVentuor(cb: cbYouAreHereVentuorList)
    }

    fileprivate func cbYouAreHereVentuorList(_ data: Data?, error: NSError?) -> Void {
        if data != nil && !data!.isEmpty {
            print(String(data: data!, encoding: .utf8)!)
            do {
                let response = try JSONDecoder().decode(VentuorList.self, from: data!)
                print(response)
                
                if let ventuors = response.result?.ventuors {
                    youAreHereVentuorList = ventuors
                    if ventuors.count > 0 {
                        isThereSomethingHere = true
                    }
                }
            } catch {
                self.message = Message(title: "Error", message: "Something went wrong. Server may be offline.")
                //fatalError("Could not decode VentuorList: \(error)")
            }
        } else {
            print("Error: Data is nil. func cbYouAreHereVentuorList()")
        }
    }

    func getWhatsHereVentuorsList() {
        initialize()
        let services = Services(baseURL: API.baseURL + "/mobile/getMobileWhatsHereVentuorsList")
        services.getMobileWhatsHereVentuorsList(cb: cbWhatsHereVentuorsList)
    }

    fileprivate func cbWhatsHereVentuorsList(_ data: Data?, error: NSError?) -> Void {
        if data != nil {
            print(String(data: data!, encoding: .utf8)!)
        } else {
            print("Error: Data is nil. func cbWhatsHereVentuorsList()")
        }
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

//    func getUsersSavedVentuors() {
//        initialize()
//        let services = Services(baseURL: API.baseURL + "/mobile/getSavedVentuors")
//        services.getSavedVentuors(cb: cbSavedVentuorList)
//    }
//    fileprivate func cbSavedVentuorList(_ data: Data?, error: NSError?) -> Void {
//        prepare()
//        if data != nil {
//            print(String(data: data!, encoding: .utf8)!)
//            do {
//                let response = try JSONDecoder().decode(MobileGetSavedVentuorsResponseResult.self, from: data!)
//                print(response)
//                
//                savedVentuors = response.result?.savedVentuors ?? [SaveFollowVentuor]()
//                isReady(ventuors: savedVentuors)
//            } catch {
//                fatalError("Could not decode MobileGetSavedVentuorsResponseResult: \(error)")
//            }
//        } else {
//            print("Error, data returned null in SaveVentuors()")
//        }
//    }

//    func getUsersFollowingVentuors() {
//        initialize()
//        let services = Services(baseURL: API.baseURL + "/mobile/getFollowingVentuors")
//        services.getFollowingVentuors(cb: cbFollowingVentuorList)
//    }
//    fileprivate func cbFollowingVentuorList(_ data: Data?, error: NSError?) -> Void {
//        prepare()
//        print(String(data: data!, encoding: .utf8)!)
//        do {
//            let response = try JSONDecoder().decode(MobileGetFollowingVentuorsResponseResult.self, from: data!)
//            print(response)
//            
//            followingVentuors = response.result?.followingVentuors ?? [SaveFollowVentuor]()
//            isReady(ventuors: followingVentuors)
//        } catch {
//            fatalError("Could not decode MobileGetFollowingVentuorsResponseResult: \(error)")
//        }
//    }

    func isReady(ventuors: [SaveFollowVentuor]) {
        if ventuors.isEmpty {
            displayStatusMessage = "No available Ventuors to show"
        } else {
            displayStatusMessage = "Ready"
        }
    }

    func logout() {
        Auth.shared.logout()
    }
    
    // This is used for error message popups that occurr on the server side.
    // The error messages come from the server, and this is used to display those
    @Published var message: Message? = nil
    struct Message: Identifiable {
        let id = UUID()
        let title: String
        let message: String
    }

}
