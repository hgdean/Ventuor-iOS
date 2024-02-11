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
        var username: String?
    }
    
    enum KeychainKey: String {
        case accessToken
        case userKey
        case username
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
            userKey: keychain.string(forKey: KeychainKey.userKey.rawValue),
            username: keychain.string(forKey: KeychainKey.username.rawValue)
        )
    }
    
    func setCredentials(accessToken: String, userKey: String, username: String) {
        keychain.set(accessToken, forKey: KeychainKey.accessToken.rawValue)
        keychain.set(userKey, forKey: KeychainKey.userKey.rawValue)
        keychain.set(username, forKey: KeychainKey.username.rawValue)

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

    func getUsername() -> String? {
        return getCredentials().username
    }

    func logout() {
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.accessToken.rawValue)
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.userKey.rawValue)
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.username.rawValue)

        loggedIn = false
    }
    
}
