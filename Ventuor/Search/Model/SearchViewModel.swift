//
//  SearchViewModel.swift
//  Ventuor
//
//  Created by Sam Dean on 2/29/24.
//

import Foundation

var searchCategoryList: [String] = ["Dine", "Desserts & Sweets", "Coffee & Tea", "Drinks", "Shopping", "Auto fuel", "Nighttime fun", "Markets & Groceries", "Money" ,"Books", "Liquor", "Flower shops", "Cars & Trucks", "Convenience stores", "Health & Fitness", "Hospitals & Pharmacies", "Hotel & Travel", "Solans & Spas", "Home Services", "Mail/Print/Copy", "Public Services"]

var searchCategoryList1: [String] = ["Dine", "Desserts & Sweets", "Coffee & Tea", "Drinks", "Shopping", "Auto fuel", "Nighttime fun"]
var searchCategoryList2: [String] = ["Markets & Groceries", "Money" ,"Books", "Liquor", "Flower shops", "Cars & Trucks", "Convenience stores"]
var searchCategoryList3: [String] = ["Health & Fitness", "Hospitals & Pharmacies", "Hotel & Travel", "Solans & Spas", "Home Services", "Mail/Print/Copy", "Public Services"]

struct Category {
    var title: String
    var icon: String
    var bgColor: String
}
var searchCategoryListAll1: [Category] = [
    .init(title: "Dine",
        icon: "static:images/category/dine.png",
        bgColor: "#D5EEEF"),
    .init(
        title: "Desserts & Sweets",
        icon: "static:images/category/desserts-sweets.png",
        bgColor: "#EDF2D4"
    ),
    .init(
        title: "Coffee & Tea",
        icon: "static:images/category/coffee-tea.png",
        bgColor: "#EEE5DF"
    ),
    .init(
        title: "Drinks",
        icon: "static:images/category/drinks.png",
        bgColor: "#D3F5DC"
    ),
    .init(
        title: "Shopping",
        icon: "static:images/category/shopping.png",
        bgColor: "#D6D5E3"
    ),
    .init(
        title: "Auto fuel",
        icon: "static:images/category/auto-fuel.png",
        bgColor: "#D4DDE7"
    ),
    .init(
        title: "Nighttime fun",
        icon: "static:images/category/nighttime-fun.png",
        bgColor: "#F7F7D3"
    )]
    var searchCategoryListAll2: [Category] = [
    .init(
        title: "Markets & Groceries",
        icon: "static:images/category/markets-groceries.png",
        bgColor: "#D4DCD4"
    ),
    .init(
        title: "Money",
        icon: "static:images/category/money.png",
        bgColor: "#D5DEED"
    ),
    .init(
        title: "Books",
        icon: "static:images/category/books.png",
        bgColor: "#E9F5F4"
    ),
    .init(
        title: "Liquor",
        icon: "static:images/category/liquor.png",
        bgColor: "#F5D3E9"
    ),
    .init(
        title: "Flower shops",
        icon: "static:images/category/flower-shops.png",
        bgColor: "#F0DBD4"
    ),
    .init(
        title: "Cars & Trucks",
        icon: "static:images/category/cars-trucks.png",
        bgColor: "#D2F8ED"
    ),
    .init(
        title: "Convenience stores",
        icon: "static:images/category/convenience-stores.png",
        bgColor: "#F6F5EE"
    )]

    var searchCategoryListAll3: [Category] = [
    .init(
        title: "Health & Fitness",
        icon: "static:images/category/health-fitness.png",
        bgColor: "#E5E5F5"
    ),
    .init(
        title: "Hospitals & Pharmacies",
        icon: "static:images/category/hospitals-pharmacies.png",
        bgColor: "#DCD7D4"
    ),
    .init(
        title: "Hotel & Travel",
        icon: "static:images/category/hotel-travel.png",
        bgColor: "#D5D5E1"
    ),
    .init(
        title: "Salons & Spas",
        icon: "static:images/category/salons-spas.png",
        bgColor: "#F6F0E4"
    ),
    .init(
        title: "Home services",
        icon: "static:images/category/home-services.png",
        bgColor: "#F8D2D4"
    ),
    .init(
        title: "Mail/Print/Copy",
        icon: "static:images/category/mail-print-copy.png",
        bgColor: "#D2F8D6"
    ),
    .init(
        title: "Public Services",
        icon: "static:images/category/public-services.png",
        bgColor: "#D3D2F8"
    )]

class SearchViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var ventuors: [VentuorData] = [VentuorData]()
    @Published var displayStatusMessage: String = ""

    @Published var searchResult: Bool = false
    
    static var sample = SearchViewModel()

    func getVentuorListData() {
        if searchTerm != "" {
            ventuors = []
            let services = Services(baseURL: API.baseURL + "/mobile/getVentuorListForSearch")
            services.getSearchData(searchCategory: "", searchTerm: searchTerm, pageNumber: 1, cb: cb)
            displayStatusMessage = "Loading..."
        }
    }

    func getVentuorListData(category: String) {
        if category != "" {
            ventuors = []
            let services = Services(baseURL: API.baseURL + "/mobile/getVentuorListForSearch")
            services.getSearchData(searchCategory: category, searchTerm: "", pageNumber: 1, cb: cb)
            displayStatusMessage = "Loading..."
        }
    }

    fileprivate func cb(_ data: Data?, error: NSError?) -> Void {

        print(String(data: data!, encoding: .utf8)!)
        
        do {
            let response = try JSONDecoder().decode(VentuorList.self, from: data!)
            print(response)
            if let responseVentuorList = response.result?.ventuors {
                if !responseVentuorList.isEmpty {
                    ventuors = response.result?.ventuors ?? []
                    searchResult = true
                } else {
                    errorSearchResult = ErrorSearchResult.EMPTY
                }
            }
            displayStatusMessage = "Ready"
        } catch {
            fatalError("Could not decode VentuorList: \(error)")
        }
    }
    
    @Published var errorSearchResult: Swift.Error?
    enum ErrorSearchResult: LocalizedError {
        case EMPTY

        var rawValue: String {
            switch self {
            case .EMPTY:
                return "EMPTY"
            }
        }
        
        var errorDescription: String? {
            switch self {
            case .EMPTY:
                return "Nothing Found"
            }
        }
        var recoverySuggestion: String? {
            switch self {
            case .EMPTY:
                return "Your search yielded no results. Try modifying your keywords."
            }
        }
    }
}
