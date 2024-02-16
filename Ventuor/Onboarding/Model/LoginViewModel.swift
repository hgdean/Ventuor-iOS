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

    @Published var emailOrUsername: String = ""
    @Published var emailAddressMasked: String = ""
    @Published var resetCode: String = ""
    @Published var newPassword1: String = ""
    @Published var newPasswordConfirm: String = ""

    static var sample: LoginViewModel = LoginViewModel()
    
    @Published var showUsernameOrEmailPage: Bool = false
    @Published var showPasswordResetPage: Bool = false

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
                
                if let errorMessage = response.error?.errorMessage {
                    message = Message(title: "Login", message: errorMessage)
                } else {
                    authToken = response.result?.authenticationToken
                    userKey = response.result?.userKey
                                
                    if(authToken != nil) {
                        Auth.shared.setCredentials(
                            accessToken: authToken!,
                            userKey: userKey!,
                            username: ""
                        )
                    } else {
                        message = Message(title: "Login", message: "Something went wrong")
                    }
                }
            } catch {
                fatalError("Could not create LoginResponse: \(error)")
            }
        } else if (error != nil) {
            if (error?.code == 401) {
                message = Message(title: "Login", message: "Login attempt failed.")
            } else {
                message = Message(title: "Something went wrong", message: error!.localizedDescription)
            }
        } else {
            message = Message(title: "Failure!", message: "Login attempt failed.")
        }
    }

    func sendEmailForPasswordReset(userInput: String) {
        if userInput.isEmpty {
            error = Error.fieldEmpty
        } else {
            emailOrUsername = userInput
            let services = Services(baseURL: API.baseURL + "/mobile/mobileSendEmailForPassReset")
            services.sendEmailForPasswordReset(emailOrUsername, cb: cbSendEmailForPasswordReset)
        }
    }
    
    fileprivate func cbSendEmailForPasswordReset(_ data: Data?, error: NSError?) -> Void {
        
        print(String(data: data!, encoding: .utf8)!)

        if (data != nil) {
            do {
                let response = try JSONDecoder().decode(MobilePassResetResponse.self, from: data!)
                print(response)
                if let errorMessage = response.error?.errorMessage {
                    message = Message(title: "Password Reset Error", message: errorMessage)
                } else {
                    self.showUsernameOrEmailPage.toggle()
                    self.emailAddressMasked = response.result?.email ?? ""
                }
            } catch {
                fatalError("Could not create MobilePassResetResponse: \(error)")
            }
        } else if (error != nil) {
            if (error?.code == 401) {
                message = Message(title: "Authorization Error!", message: "Password Reset Request Failed.")
            } else {
                message = Message(title: "Something went wrong", message: error!.localizedDescription)
            }
        } else {
            message = Message(title: "Failure!", message: "Password Reset Request Failed.")
        }
    }
    
    func resetPasswordAndLogin() {
        if newPassword1.isEmpty {
        } else {
            let services = Services(baseURL: API.baseURL + "/mobile/mobileValidateAndLoginVentuorUser")
            services.resetPasswordAndLogin(resetCode, newPassword: newPassword1, username: emailOrUsername, cb: cbResetPasswordAndLogin)
        }
    }
    
    fileprivate func cbResetPasswordAndLogin(_ data: Data?, error: NSError?) -> Void {
        var authToken: String? = nil
        var userKey: String? = nil

        print(String(data: data!, encoding: .utf8)!)

        if (data != nil) {

            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data!)
                print(response)
                
                if let errorMessage = response.error?.errorMessage {
                    message = Message(title: "Validation failed", message: errorMessage)
                } else {
                    authToken = response.result?.authenticationToken
                    userKey = response.result?.userKey
                    
                    if(authToken != nil) {
                        Auth.shared.setCredentials(
                            accessToken: authToken!,
                            userKey: userKey!,
                            username: ""
                        )
                    } else {
                        message = Message(title: "Login", message: "Something went wrong")
                    }
                }
            } catch {
                fatalError("Could not create LoginResponse: \(error)")
            }
        } else if (error != nil) {
            if (error?.code == 401) {
                message = Message(title: "Change Password", message: "Password change failed.")
            } else {
                message = Message(title: "Something went wrong", message: error!.localizedDescription)
            }
        } else {
            message = Message(title: "Change Password", message: "Password change failed.")
        }
    }
        
    
    // This error handler are used for errors that are initiated locally. Meaning,
    // the error are UI/User instigated. So the type and message are defined here.
    @Published var error: Swift.Error?
    enum Error: LocalizedError {
        case fieldEmpty

        var errorDescription: String? {
            switch self {
            case .fieldEmpty:
                return "Empty field"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .fieldEmpty:
                return "Enter a username or email"
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

}
