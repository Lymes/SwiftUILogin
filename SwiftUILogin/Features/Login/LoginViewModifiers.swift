//
//  TextFieldModifier.swift
//  LoginTest
//
//  Created by Leonid Mesentsev on 22/10/22.
//

import SwiftUI

struct LoginInput: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.TextColorPrimary)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.TextColorSecondary, style: StrokeStyle(lineWidth: 1.0)))
    }
}

struct WelcomeText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.TextColorPrimary)
            .padding()
    }
}

struct Logo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100.0, height: 60.0)
            .foregroundColor(Color.TextColorSecondary)
            .padding()
    }
}

struct LoginButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.BackgroundColor)
            .background(Color.TextColorPrimary)
            .cornerRadius(10.0)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.TextColorSecondary, style: StrokeStyle(lineWidth: 1.0)))
    }
}

struct SettingsButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.TextColorPrimary)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.TextColorSecondary, style: StrokeStyle(lineWidth: 1.0)))
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(configuration.isOn ? Color.TextColorPrimary : Color.TextColorSecondary)
                .font(.system(size: 20, weight: .regular, design: .default))
            configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }        
    }
}
