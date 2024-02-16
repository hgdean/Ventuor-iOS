//
//  VentuorListModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/16/24.
//

import Foundation

class VentuorListModel: ObservableObject {
    
    @Published var ventuorList: VentuorList? = nil
    @Published var displayStatusMessage: String? = nil

    static var sample = VentuorListModel()

    func getVentuorListData() {
        ventuorList = nil
        displayStatusMessage = "Loading..."
        let services = Services(baseURL: API.baseURL + "/mobile/getVentuorListForSearch")
        services.getSearchData(searchCategory: "Desserts & Sweets", searchTerm: "", pageNumber: 1, cb: cb)
        displayStatusMessage = "Processing..."
    }

    fileprivate func cb(_ data: Data?, error: NSError?) -> Void {

        print(String(data: data!, encoding: .utf8)!)
        
        do {
            let response = try JSONDecoder().decode(VentuorList.self, from: data!)
            print(response)
            ventuorList = response
        } catch {
            fatalError("Could not decode VentuorList: \(error)")
        }
    }
}
