//
//  SettingsView.swift
//  LoginTest
//
//  Created by Leonid Mesentsev on 22/10/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = SettingsViewModel()

    var body: some View {
        ZStack {
            Color.BackgroundColor
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .modifier(CloseButton())
                    }
                }
                .padding(20)
                Spacer()
            }
            VStack {
                HStack {
                    Text("IP Controller:")
                    switch viewModel.connectionMethod {
                    case .manual:
                        TextField("IP address", text: $viewModel.manualIPAddress)
                            .foregroundColor(viewModel.manualIPInvalid ? .red : Color.TextColorPrimary)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.TextColorSecondary, style: StrokeStyle(lineWidth: 1.0)))
                            .keyboardType(.numberPad)
                            .onChange(of: viewModel.manualIPAddress) {
                                self.viewModel.validateIpAddress($0)
                            }
                    case .cloud:
                        Text("Cloud IP")
                    case .scanned:
                        if viewModel.isScanning {
                            Text("Scanning...")
                            ActivityIndicator(isAnimating: .constant(true), style: .medium)
                        } else {
                            Text(viewModel.scannedIPAddress.isEmpty ? "Unknown" : viewModel.scannedIPAddress)
                        }
                    }
                }
                .padding([.leading, .bottom, .trailing], 30.0)

                VStack(alignment: .leading) {
                    Toggle(isOn: $viewModel.manual) {
                        Text("Input manually")
                    }
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $viewModel.cloud) {
                        Text("Use Cloud")
                    }
                    .toggleStyle(CheckboxStyle())
                }
                .padding(.bottom, 40)

                Button {
                    viewModel.rescan()
                } label: {
                    Text("Discover")
                        .frame(width: 200.0, height: 44.0)
                }
                .modifier(SettingsButton())
            }
            .onChange(of: viewModel.connectionMethod) { _ in
                viewModel.scanIfNeeded()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

