//
//  LoginViewModel.swift
//  SwiftAPICalls
//
//  Created by H Sam Dean on 12/26/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var password: String = ""

    func login() {
        let services = Services(baseURL: API.baseURL + "/mobile/mobileLogin")
        services.login(userName, password: password, cb: loginServiceCallback)
    }
    
    fileprivate func loginServiceCallback(_ data: Data?, error: NSError?) -> Void {

        var authToken: String? = nil
        var userKey: String? = nil

        if (data != nil) {

            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data!)
                print(response)
                print(response.result?.userKey ?? "")
                print(response.result?.authenticationToken ?? "")
                print(response.error?.errorMessage ?? "")
                
                authToken = response.result?.authenticationToken
                userKey = response.result?.userKey
                            
                if(authToken != nil) {
                    // The new Auth in this tutorial
                    Auth.shared.setCredentials(
                        accessToken: authToken!,
                        userKey: userKey!
                    )
//                    ContentManager(baseURL: Settings.baseURL).updatedUserProfile(false)
//                    ScreenManager.instance.buildAppInterface()
                    
                } else {
                    // let errorMessage = response.error?.errorMessage
                    // Utils.showMessage(errorMessage!, withTitle: "Login")
                }
            } catch {
            }
        } else if (error != nil) {
            if (error?.code == 401) {
                // Utils.showMessage("Login attempt failed.", withTitle: "Login")
            } else {
                // Utils.showMessage(error!.localizedDescription, withTitle: "Something went wrong")
            }
        } else {
            // Utils.showMessage("Login attempt failed.", withTitle: "Login")
        }
//        controller!.hideLoadingIndicator()
    }

}
