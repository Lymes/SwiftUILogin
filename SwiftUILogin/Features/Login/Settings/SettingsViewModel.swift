//
//  SettingsViewModel.swift
//  LoginTest
//
//  Created by Leonid Mesentsev on 22/10/22.
//

import SwiftUI

enum ConnectionMethod: Int {
    case scanned = 0
    case manual
    case cloud
}

final class SettingsViewModel: ObservableObject {
    
    // MARK: Publishers

    @AppStorage("connectionMethod")
    var connectionMethod: ConnectionMethod = .scanned
    @AppStorage("manualIPAddress")
    var manualIPAddress: String = ""
    @AppStorage("scannedIPAddress")
    var scannedIPAddress: String = ""
    
    @Published var manualIPInvalid: Bool = false
    @Published var isScanning: Bool = false

    var manual: Bool {
        get {
            connectionMethod == .manual
        }
        set {
            connectionMethod = newValue ? .manual : .scanned
        }
    }
    
    var cloud: Bool {
        get {
            connectionMethod == .cloud
        }
        set {
            connectionMethod = newValue ? .cloud : .scanned
        }
    }
    
    init() {
        manualIPInvalid = !verifyWholeIP(test: manualIPAddress)
        scanIfNeeded()
    }
    
    func scanIfNeeded() {
        guard connectionMethod == .scanned, scannedIPAddress.isEmpty else { return }
        isScanning = true
        print("Scan...")
        Task {
            try await Task.sleep( nanoseconds: 5_000_000_000)
            DispatchQueue.main.async {
                self.isScanning = false
                self.scannedIPAddress = "192.168.1.100"
            }
        }
    }

    func rescan() {
        scannedIPAddress = ""
        if connectionMethod != .scanned {
            connectionMethod = .scanned
        } else {
            scanIfNeeded()
        }
    }

    func validateIpAddress(_ newValue: String) {
        let pattern_1 = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])[.]){0,3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])?$"
        let regexText_1 = NSPredicate(format: "SELF MATCHES %@", pattern_1)
        manualIPInvalid = !regexText_1.evaluate(with: newValue)
    }
    
    func verifyManualIP() {
        manualIPInvalid = !verifyWholeIP(test: manualIPAddress)
    }
    
    // MARK: Private
    
    func verifyWholeIP(test: String) -> Bool {
        let pattern_2 = "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})"
        let regexText_2 = NSPredicate(format: "SELF MATCHES %@", pattern_2)
        let result_2 = regexText_2.evaluate(with: test)
        return result_2
    }
}
