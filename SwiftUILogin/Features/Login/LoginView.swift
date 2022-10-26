//
//  LoginView.swift
//  LoginTest
//
//  Created by Leonid Mesentsev on 22/10/22.
//

import SwiftUI
import Combine

struct LoginView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @StateObject var viewModel = LoginViewModel()
    @State var showingSettings = false
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color.BackgroundColor.ignoresSafeArea()
                VStack {
                    Spacer()
                    if self.verticalSizeClass != .compact {
                        Image("login_logo")
                            .resizable()
                            .frame(width: 200, height: 120)
                    }
                    TextField("Username", text: $viewModel.username)
                        .modifier(LoginInput())
                        .padding(.top, 20)
                    SecureInputView("Password", text: $viewModel.password)
                        .modifier(LoginInput())
                    
                    Toggle(isOn: $viewModel.rememberMe) {
                        Text("Remember Me")
                    }
                    .toggleStyle(CheckboxStyle())
                    .padding(.top, 20)
                    
                    Button {
                        viewModel.loginTapped()
                    } label: {
                        Text("Login")
                            .frame(width: 200.0, height: 44.0)
                    }
                    .modifier(LoginButton())
                    .padding(.top, 40)
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Text("Settings")
                            .frame(width: 200.0, height: 44.0)
                    }
                    .modifier(SettingsButton())
                    .padding(.top, 10)
                    Spacer()
                    if self.verticalSizeClass != .compact {
                        Image("login_footer")
                            .resizable()
                            .frame(width: 240, height: 60)
                    }
                }
                .padding()
            }
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .sheet(isPresented: $viewModel.showingAlert) {
                AlertView(viewModel: viewModel.alertContent!)
                //.presentationDetents([.medium, .large])
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
