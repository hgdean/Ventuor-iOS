//
//  LoginViewModel.swift
//  SwiftAPICalls
//
//  Created by H Sam Dean on 12/26/23.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    // This error handler are used for errors that are initiated locally. Meaning,
    // the error are UI/User instigated. So the type and message are defined here.
    @Published var error: Swift.Error?
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

    // This is used for error message popups that occurr on the server side.
    // The error messages come from the server, and this is used to display those
    @Published var message: Message? = nil
    struct Message: Identifiable {
        let id = UUID()
        let title: String
        let message: String
    }

    @Published var title: String = ""

    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmationCode: String = ""

    @Published var isSignupEmailValid: Bool = false
    @Published var isSignupValid: Bool = false

    static var sample = SignupViewModel()

    func validateEmail() {
        print(fullname)
        print(email)

        if email.isEmpty {
            error = Error.emailEmpty
        } else {
            let services = Services(baseURL: API.baseURL + "/mobile/mobileFindEmailExists")
            services.mobileFindEmailExists(email, cb: validateEmailCallback)
        }
    }

    func validateSignup() {
        print(fullname)
        print(email)
        print(password)
        
        if password.isEmpty {
            error = Error.passwordEmpty
        } else {
            let services = Services(baseURL: API.baseURL + "/mobile/mobileSendEmailForSignUp")
            services.sendEmailForSignUp(email, phone: "", cb: validateSignupCallback)
        }
    }

    func validateSignupConfirmationCode() {
        print(fullname)
        print(email)
        print(password)
        print(confirmationCode)

        if confirmationCode.isEmpty {
            error = Error.confirmationCodeEmpty
        } else {
            let services = Services(baseURL: API.baseURL + "/mobile/mobileValidateAndEmailSignUpVentuorMobileUser")
            services.mobileValidateAndEmailSignUpVentuorMobileUser(email,
                                                                   fullName: fullname,
                                                                   password: password,
                                                                   userCode: confirmationCode,
                                                                   cb: validateSignupConfirmationCodeCallback)
        }
    }
    
    fileprivate func validateEmailCallback(_ data: Data?, error: NSError?) -> Void {
        if (error != nil) {
            print(error!.localizedDescription)
            message = Message(title: "Something went wrong", message: error!.localizedDescription)
            return
        }

        print(String(data: data!, encoding: .utf8)!)
        
        // {"result":null,"error":{"errorMessage":"This email is already registered on our system. If it belongs to you please try to login. Otherwise, please enter a different email."}}
        //{"result":{"resultCode":0,"resultMessage":"Email doesn't exist"},"error":null}

        if (data != nil) {
            do {
                let response = try JSONDecoder().decode(SignupEmailCheckResponse.self, from: data!)
                print(response)
                print(response.result ?? "")
                print(response.error?.errorMessage ?? "")
                let errorMessage = response.error?.errorMessage ?? ""

                if errorMessage == "" {
                    isSignupEmailValid = true
                }
                else {
                    message = Message(title: "Signup Error", message: errorMessage)
                }
            }
            catch {
                print("Exception in JSONDecoder()")
            }
        }
    }
    
    func validateSignupCallback(_ data: Data?, error: NSError?) {
        if (error != nil) {
            message = Message(title: "Something went wrong", message: error!.localizedDescription)
            return
        }

        print(String(data: data!, encoding: .utf8)!)

        if (data != nil) {
            
            do {
                let response = try JSONDecoder().decode(PhoneAndEmailServerResponse.self, from: data!)
                print(response)
                print(response.result ?? "")
                print(response.error?.errorMessage ?? "")
                let errorMessage = response.error?.errorMessage ?? ""

                if errorMessage == "" {
                    isSignupValid = true
                }
                else {
                    message = Message(title: "Validation failed", message: errorMessage)
                }
            }
            catch {
                print("Exception in JSONDecoder()")
            }
        }
    }
    
    private func validateSignupConfirmationCodeCallback(data: Data?, error: NSError?) -> Void {
        if (error != nil) {
            message = Message(title: "Something went wrong", message: error!.localizedDescription)
            return
        }

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
                let errorMessage = response.error?.errorMessage ?? ""

                authToken = response.result?.authenticationToken
                userKey = response.result?.userKey
                            
                if(authToken != nil) {
                    // The new Auth in this tutorial
                    Auth.shared.setCredentials(
                        accessToken: authToken!,
                        userKey: userKey!,
                        username: ""
                    )
                } else {
                    message = Message(title: "Signup Confirmation", message: errorMessage)
                }
            } catch {
            }
        } else if (error != nil) {
            if (error?.code == 401) {
                message = Message(title: "Signup Confirmation", message: "Signup failed.")
            } else {
                message = Message(title: "Something went wrong", message: error!.localizedDescription)
            }
        } else {
            message = Message(title: "Signup Confirmation", message: "Signup failed.")
        }
    }
}
