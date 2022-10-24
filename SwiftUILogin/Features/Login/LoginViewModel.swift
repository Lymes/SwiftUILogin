//
//  LoginViewModel.swift
//  LoginTest
//
//  Created by Leonid Mesentsev on 22/10/22.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    
    // MARK: Publishers
    @AppStorage("rememberMe")
    var rememberMe: Bool = false
    @AppStorage("useBiometrics")
    var useBiometrics: Bool = false
    @AppStorage("lastUsername")
    var username: String = ""
    
    @Published var password: String = ""
    @Published var alertContent: AlertViewModel?
    
    private let keychain = Keychain(server: "icc.com", protocolType: .https)


    var showingAlert: Bool {
        get { alertContent != nil }
        set { DispatchQueue.main.async { self.alertContent = nil } }
    }
    
    init() {
        if rememberMe, let password = keychain[username] {
            self.password = password
            if doLogin() {
                postLogin()
            }
        }
    }
    
    func loginTapped() {
        if doLogin() {
            postLogin()
        }
    }
    
    private func doLogin() -> Bool {
        return true
    }
    
    private func postLogin() {
        if !useBiometrics {
            alertContent = AlertViewModel(systemImage: "faceid", title: "Face ID", subtitle: "Do you want to use FaceID to access the next time?") {
                self.useBiometrics = true
                print("OK!")
            }
        }
        keychain[username] = self.rememberMe ? password : nil
    }
}
