//
//  AlertView.swift
//  LoginTest
//
//  Created by Leonid Mesentsev on 23/10/22.
//

import SwiftUI

struct AlertView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel: AlertViewModel
    
    var body: some View {
        ZStack {
            Color.BackgroundColor.ignoresSafeArea()
            if viewModel.showClose {
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
            }
            VStack {
                if let imageName = viewModel.image {
                    Image(imageName)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                if let imageName = viewModel.systemImage {
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                Text(viewModel.title)
                    .font(.largeTitle)
                    .foregroundColor(Color.TextColorPrimary)
                    .padding(.top, 30.0)
                if let subtitle = viewModel.subtitle {
                    Text(subtitle)
                        .padding()
                        .font(.body)
                        .foregroundColor(Color.TextColorSecondary)
                }
                if let confirm = viewModel.confirm {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .frame(width: 100.0, height: 44.0)
                        }
                        .foregroundColor(Color.TextColorPrimary)
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.TextColorSecondary, style: StrokeStyle(lineWidth: 1.0)))
                        .padding()
                        Button {
                            dismiss()
                            confirm()
                        } label: {
                            Text("OK")
                                .frame(width: 100.0, height: 44.0)
                        }
                        .foregroundColor(Color.BackgroundColor)
                        .background(Color.TextColorPrimary)
                        .cornerRadius(10.0)
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.TextColorSecondary, style: StrokeStyle(lineWidth: 1.0)))
                        .padding()
                    }
                } else {
                    Button {
                        dismiss()
                    } label: {
                        Text("OK")
                            .frame(width: 100.0, height: 44.0)
                    }
                    .modifier(LoginButton())
                    .padding(.top, 20.0)
                }
            }
            //.padding(.horizontal, 40.0)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(viewModel: AlertViewModel(systemImage: "faceid", title: "Title", subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
    }
}
