//
//  UserProfileModel.swift
//  Ventuor
//
//  Created by Sam Dean on 2/3/24.
//

import SwiftUI
import SwiftData

class UserProfileModel: ObservableObject {
    
    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var emailConfirmationCode: String = ""
    @Published var username: String = ""
    @Published var isEmailValid: Bool = false
    @Published var password: String = ""
    @Published var newPassword: String = ""

    static let shared: UserProfileModel = UserProfileModel()

    @Published var userProfileDataModel: UserProfileDataModel?

    @Environment(\.modelContext) private var context
    @Query(sort: \UserProfileDataModel.userKey) var userProfileDataModels: [UserProfileDataModel]

    @Published var showNameProfileSheet: Bool = false
    @Published var showEmailProfileSheet: Bool = false
    @Published var showUsernameProfileSheet: Bool = false
    @Published var showPasswordProfileSheet: Bool = false

    func loadUserProfile(cb: @escaping (_ data: Data?, _ err: NSError?) -> Void) {
        let services = Services(baseURL: API.baseURL + "/mobile/getProfile")

        services.getUserProfile(cb: { data, error in
            print(String(data: data!, encoding: .utf8)!)

            do {
                let response = try JSONDecoder().decode(UserProfile.self, from: data!)
                
                if let profileDetails = response.result?.profileDetails {
                    let loadedUserProfile = UserProfileDataModel(data: profileDetails)
                    if !loadedUserProfile.userKey.isEmpty {
                        self.userProfileDataModel = loadedUserProfile
                        cb(data, error)
                    }
                }
            } catch {
            }
        })
    }

    func refreshUserProfile() {
        let services = Services(baseURL: API.baseURL + "/mobile/getProfile")

        services.getUserProfile(cb: { data, error in
            print(String(data: data!, encoding: .utf8)!)

            do {
                let response = try JSONDecoder().decode(UserProfile.self, from: data!)
                
                if let profileDetails = response.result?.profileDetails {
                    let loadedUserProfile = UserProfileDataModel(data: profileDetails)
                    if !loadedUserProfile.userKey.isEmpty {
                        self.userProfileDataModel = loadedUserProfile
                    }
                }
            } catch {
            }
        })
    }
    
    func saveFullname() {
        let services = Services(baseURL: API.baseURL + "/mobile/saveProfileFullName")
        services.saveProfileFullName(fullname, cb: cbSaveProfileFullname)
    }
    fileprivate func cbSaveProfileFullname(_ data: Data?, error: NSError?) -> Void {
        print(String(data: data!, encoding: .utf8)!)
        
        do {
            let response = try JSONDecoder().decode(UserProfileData.self, from: data!)
            
            let errorMessage = response.error?.errorMessage ?? ""
            if errorMessage == "" {
                refreshUserProfile()
                showNameProfileSheet = false
            }
            else {
                message = Message(title: "Error", message: errorMessage)
            }
        } catch {
        }
    }
    
    func validateEmail() {
        print(fullname)

        if email.isEmpty {
            error = Error.emailEmpty
        } else {
            let services = Services(baseURL: API.baseURL + "/mobile/mobileFindEmailExists")
            services.mobileFindEmailExists(email, cb: validateEmailCallback)
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
                    validateSignup()
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
    func validateSignup() {
        let services = Services(baseURL: API.baseURL + "/mobile/mobileSendEmailForSignUp")
        services.sendEmailForSignUp(email, phone: "", cb: validateSignupCallback)
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
                    refreshUserProfile()
                    isEmailValid = true
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
    func saveEmail() {
        let services = Services(baseURL: API.baseURL + "/mobile/saveProfileEmail")
        services.saveProfileEmail(email, confirmCode: emailConfirmationCode, cb: validateSaveEmailCallback)
    }
    fileprivate func validateSaveEmailCallback(_ data: Data?, error: NSError?) -> Void {
        if (error != nil) {
            print(error!.localizedDescription)
            message = Message(title: "Something went wrong", message: error!.localizedDescription)
            return
        }

        print(String(data: data!, encoding: .utf8)!)

        if (data != nil) {
            do {
                let response = try JSONDecoder().decode(SignupEmailCheckResponse.self, from: data!)
                print(response)
                print(response.result ?? "")
                print(response.error?.errorMessage ?? "")
                let errorMessage = response.error?.errorMessage ?? ""

                if errorMessage == "" {
                    refreshUserProfile()
                    showEmailProfileSheet = false
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

    func saveUsername() {
        let services = Services(baseURL: API.baseURL + "/mobile/saveProfileUsername")
        services.saveProfileUsername(username, cb: validateSaveUsernameCallback)
    }
    fileprivate func validateSaveUsernameCallback(_ data: Data?, error: NSError?) -> Void {
        if (error != nil) {
            print(error!.localizedDescription)
            message = Message(title: "Something went wrong", message: error!.localizedDescription)
            return
        }

        print(String(data: data!, encoding: .utf8)!)

        if (data != nil) {
            do {
                let response = try JSONDecoder().decode(SignupEmailCheckResponse.self, from: data!)
                print(response)
                print(response.result ?? "")
                print(response.error?.errorMessage ?? "")
                let errorMessage = response.error?.errorMessage ?? ""

                if errorMessage == "" {
                    refreshUserProfile()
                    showUsernameProfileSheet = false
                }
                else {
                    message = Message(title: "Error", message: errorMessage)
                }
            }
            catch {
                print("Exception in JSONDecoder()")
            }
        }
    }

    func savePassword() {
        let services = Services(baseURL: API.baseURL + "/mobile/savePassword")
        services.savePassword(username: username, newPassword: newPassword, password: password, cb: validateSavePasswordCallback)
    }
    
    private func validateSavePasswordCallback(data: Data?, error: NSError?) -> Void {
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
                    refreshUserProfile()
                    showPasswordProfileSheet = false
                } else {
                    message = Message(title: "Change Password", message: errorMessage)
                }
            } catch {
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

    func getCurrentCacheUserProfile() -> UserProfileDataModel? {
        for i in 0..<(self.userProfileDataModels.count) {
            print(userProfileDataModels[i].userKey)
            if userProfileDataModels[i].userKey == Auth.shared.getUserKey() {
                return userProfileDataModels[i]
            }
        }
        return nil
    }

    // This is used for error message popups that occurr on the server side.
    // The error messages come from the server, and this is used to display those
    @Published var message: Message? = nil
    struct Message: Identifiable {
        let id = UUID()
        let title: String
        let message: String
    }

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
                return "Please enter an email address"
            case .passwordEmpty:
                return "Enter a password. It cannot be blank."
            case .confirmationCodeEmpty:
                return "Enter the 5 digit confirmation code sent to your email"
            }
        }
    }
}
