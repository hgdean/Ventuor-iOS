//
//  SearchViewModel.swift
//  Ventuor
//
//  Created by Sam Dean on 2/29/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var ventuorList: VentuorList? = nil
    @Published var ventuors: [VentuorData] = [VentuorData]()
    @Published var displayStatusMessage: String = ""

    @Published var searchResult: Bool = false
    
    static var sample = SearchViewModel()

    func getVentuorListData() {
        if searchTerm != "" {
            ventuorList = nil
            let services = Services(baseURL: API.baseURL + "/mobile/getVentuorListForSearch")
            services.getSearchData(searchCategory: "", searchTerm: searchTerm, pageNumber: 1, cb: cb)
            displayStatusMessage = "Loading..."
        }
    }

    fileprivate func cb(_ data: Data?, error: NSError?) -> Void {

        print(String(data: data!, encoding: .utf8)!)
        
        do {
            let response = try JSONDecoder().decode(VentuorList.self, from: data!)
            print(response)
            ventuors = response.result?.ventuors ?? []
            ventuorList = response
            searchResult = true
            displayStatusMessage = "Ready"
        } catch {
            fatalError("Could not decode VentuorList: \(error)")
        }
    }
}
