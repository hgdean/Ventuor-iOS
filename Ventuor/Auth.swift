//
//  Auth.swift
//  Ventuor
//
//  Created by H Sam Dean on 12/26/23.
//

import Foundation

class Auth: ObservableObject {
    
    struct Credentials {
        var accessToken: String?
        var userKey: String?
    }
    
    enum KeychainKey: String {
        case accessToken
        case userKey
    }
    
    static let shared: Auth = Auth()
    private let keychain: KeychainWrapper = KeychainWrapper.standard
    
    @Published var loggedIn: Bool = false
    
    private init() {
        loggedIn = hasAccessToken()
    }
    
    func getCredentials() -> Credentials {
        return Credentials(
            accessToken: keychain.string(forKey: KeychainKey.accessToken.rawValue),
            userKey: keychain.string(forKey: KeychainKey.userKey.rawValue)
        )
    }
    
    func setCredentials(accessToken: String, userKey: String) {
        keychain.set(accessToken, forKey: KeychainKey.accessToken.rawValue)
        keychain.set(userKey, forKey: KeychainKey.userKey.rawValue)
        
        loggedIn = true
    }
    
    func hasAccessToken() -> Bool {
        return getCredentials().accessToken != nil
    }
    
    func getAccessToken() -> String? {
        return getCredentials().accessToken
    }

    func getUserKey() -> String? {
        return getCredentials().userKey
    }

    func logout() {
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.accessToken.rawValue)
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.userKey.rawValue)
        
        loggedIn = false
    }
    
}
