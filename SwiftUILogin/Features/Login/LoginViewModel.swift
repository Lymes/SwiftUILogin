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
            loginTapped()
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
        keychain[username] = self.rememberMe ? password : nil
    }
}
