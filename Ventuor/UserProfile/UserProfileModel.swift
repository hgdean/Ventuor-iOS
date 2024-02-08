//
//  UserProfileModel.swift
//  Ventuor
//
//  Created by Sam Dean on 2/3/24.
//

import Foundation

class UserProfileModel: ObservableObject {
    
    static let shared: UserProfileModel = UserProfileModel()

    @Published var cachedUserProfile: CacheUserProfile?
    
    func loadUserProfile(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        let services = Services(baseURL: API.baseURL + "/mobile/getProfile")
        services.getUserProfile(cb)
    }

}
