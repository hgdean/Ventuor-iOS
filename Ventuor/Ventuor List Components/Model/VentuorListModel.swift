//
//  VentuorListModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/16/24.
//

import Foundation

class VentuorListModel: ObservableObject {
    
    var ventuorList: VentuorList? = nil
    
    @Published var ventuorListData: [VentuorData]? = nil
    
    static var sample = VentuorListModel()

    func getVentuorListData() {
        let locationDataManager = LocationDataManager()
        let lat = locationDataManager.locationManager.location?.coordinate.latitude ?? 0
        let long = locationDataManager.locationManager.location?.coordinate.longitude ?? 0

        let services = Services(baseURL: API.baseURL + "/mobile/getVentuorListForSearch")
        services.getSearchData(searchCategory: "Desserts & Sweets", searchTerm: "", lat: lat, long: long, pageNumber: 1, cb: cb)
    }

    fileprivate func cb(_ data: Data?, error: NSError?) -> Void {

        print(String(data: data!, encoding: .utf8)!)
        
        do {
            let response = try JSONDecoder().decode(VentuorList.self, from: data!)
            print(response)
            
            ventuorList = response
            ventuorListData = ventuorList?.result?.ventuors
            
        } catch {
        }
    }
}
