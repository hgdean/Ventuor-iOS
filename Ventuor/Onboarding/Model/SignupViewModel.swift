//
//  LoginViewModel.swift
//  SwiftAPICalls
//
//  Created by H Sam Dean on 12/26/23.
//

import Foundation

class SignupViewModel: ObservableObject {

    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmationCode: String = ""

    @Published var isSignupEmailValid: Bool = false

    static var sample = SignupViewModel()

    func validateEmail() {
        print(fullname)
        print(email)

        let services = Services(baseURL: API.baseURL + "/mobile/mobileFindEmailExists")
        services.mobileFindEmailExists(email, cb: validateEmailCallback)
    }

    func validateSignup() {
        print(fullname)
        print(email)
        print(password)
        
        let services = Services(baseURL: API.baseURL + "/mobile/mobileSendEmailForSignUp")
        services.sendEmailForSignUp(email, phone: "", cb: validateSignupCallback)
    }

    func validateSignupConfirmationCode() {
        print(fullname)
        print(email)
        print(password)
        print(confirmationCode)

        let services = Services(baseURL: API.baseURL + "/mobile/mobileValidateAndEmailSignUpVentuorMobileUser")
        services.mobileValidateAndEmailSignUpVentuorMobileUser(email, 
                                                               fullName: fullname,
                                                               password: password,
                                                               userCode: confirmationCode,
                                                               cb: validateSignupConfirmationCodeCallback)
    }
    
    fileprivate func validateEmailCallback(_ data: Data?, error: NSError?) -> Void {
        if (error != nil) {
            print(error!.localizedDescription)
            // Utils.showMessage(error!.localizedDescription, withTitle: "Something went wrong")
            return
        }

        print(String(data: data!, encoding: .utf8)!)
        
        // {"result":null,"error":{"errorMessage":"This email is already registered on our system. If it belongs to you please try to login. Otherwise, please enter a different email."}}
        
        //{"result":{"resultCode":0,"resultMessage":"Email doesn't exist"},"error":null}
        
        isSignupEmailValid = true
        
//        if let errorMessage = json?["error"]["errorMessage"].string
//        {
//            Utils.showMessage(errorMessage, withTitle: "Signup Email Address")
//            return
//        }
//        
//        Action.executeAction([
//            "type": "PushScreenAction",
//            "options":
//                [
//                    "fullName": fullName,
//                    "email": emailField.text!,
//                    "screen": "app-signup-password"
//            ]
//        ])
    }
    
    func validateSignupCallback(_ data: Data?, error: NSError?) {
        if (error != nil) {
            // Utils.showMessage(error!.localizedDescription, withTitle: "Something went wrong")
            return
        }
        
        print(String(data: data!, encoding: .utf8)!)

//        if let errorMessage = json?["error"]["errorMessage"].string
//        {
//            Utils.showMessage(errorMessage, withTitle: "Validation failed")
//            return
//        }
//
//        let emailResponse = json?["result"]["email"].string
//        let phoneResponse = json?["result"]["phone"].string
//        
//        if (emailResponse != nil || phoneResponse != nil)
//        {
//            Action.executeAction([
//                "type": "PushScreenAction",
//                "options":
//                [
//                    "fullName": fullName,
//                    "email": email,
//                    "phoneNumber": phoneNumber,
//                    "countryCode": countryCode,
//                    "password": passwordField.text ?? "",
//                    "screen": "app-signup-confirmation"
//                ]
//            ])
//        }
    }
    
    private func validateSignupConfirmationCodeCallback(data: Data?, error: NSError?) -> Void {
        
        var authToken: String? = nil
        var userKey: String? = nil

        print(String(data: data!, encoding: .utf8)!)

        if data != nil {
            
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
                        refreshToken: userKey!
                    )
                } else {
                    // let errorMessage = response.error?.errorMessage
                    // Utils.showMessage(errorMessage!, withTitle: "Login")
                }
            } catch {
            }
        } else if (error != nil) {
            if (error?.code == 401) {
                // Utils.showMessage("Signup attempt failed.", withTitle: "Signup")
            } else {
                // Utils.showMessage(error!.localizedDescription, withTitle: "Something went wrong")
            }
        } else {
            // Utils.showMessage("Signup attempt failed.", withTitle: "Login")
        }

//        if (json != nil) {
//            
//            authToken = json!["result"]["authenticationToken"].string
//            userKey = json!["result"]["userKey"].string
//            
//            if(authToken != nil) {
//                AuthInfo.token = authToken!
//                AuthInfo.userKey = userKey!
//                AuthInfo.userName = email
//                
//                ScreenManager.instance.buildAppInterface()
//                
//            } else {
//                let errorMessage = json!["error"]["errorMessage"].string
//                Utils.showMessage(errorMessage!, withTitle: "Signup Confirmation")
//            }
//            
//        } else if (error != nil) {
//            if (error?.code == 401) {
//                Utils.showMessage("Signup failed.", withTitle: "Signup Confirmation")
//            } else {
//                Utils.showMessage(error!.localizedDescription, withTitle: "Something went wrong")
//            }
//        } else {
//            Utils.showMessage("Signup failed.", withTitle: "Signup Confirmation")
//        }
//        controller.hideLoadingIndicator()
    }
}
