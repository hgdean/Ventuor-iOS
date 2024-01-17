//
//  VentuorViewModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/11/24.
//

import Foundation

class VentuorViewModel: ObservableObject {
    
    var ventuor: Ventuor? = nil
    
    @Published var ventuorData: VentuorData? = nil
    
    enum Error: LocalizedError {
        case emailEmpty
        case passwordEmpty
        case confirmationCodeEmpty

        var errorDescription: String? {
            switch self {
            case .emailEmpty:
                return "Email empty"
            case .passwordEmpty:
                return "Password empty"
            case .confirmationCodeEmpty:
                return "Confimation code empty"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .emailEmpty:
                return "Enter an email address to signup"
            case .passwordEmpty:
                return "Enter a password. It cannot be blank."
            case .confirmationCodeEmpty:
                return "Enter the 5 digit confirmation code sent to your email"
            }
        }
    }

    static var sample = VentuorViewModel()

    func getVentuorData() {
        let locationDataManager = LocationDataManager()
        let lat = locationDataManager.locationManager.location?.coordinate.latitude ?? 0
        let long = locationDataManager.locationManager.location?.coordinate.longitude ?? 0
         
        let services = Services(baseURL: API.baseURL + "/mobile/getVentuor")
//        services.getVentuorData(ventuorKey: "d1b46350-624e-11e6-bb57-fd029049b7d6", lat: lat, long: long, cb: cb)  // Apple Store Summerset
        services.getVentuorData(ventuorKey: "99b2fdc0-60cf-11e6-a287-631cdc10fbc8", lat: lat, long: long, cb: cb)    // Potbelly
//        services.getVentuorData(ventuorKey: "5433d4d0-dc31-11e6-a287-631cdc10fbc8", lat: lat, long: long, cb: cb)  // Riker Lumber
    }

    fileprivate func cb(_ data: Data?, error: NSError?) -> Void {

        print(String(data: data!, encoding: .utf8)!)
        
        do {
            let response = try JSONDecoder().decode(Ventuor.self, from: data!)
            print(response)
            
            ventuor = response
            ventuorData = ventuor?.result?.ventuor
            
        } catch {
        }
    }
    
}
