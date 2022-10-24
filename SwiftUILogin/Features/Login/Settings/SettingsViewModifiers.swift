//
//  SettingsViewModifiers.swift
//  LoginTest
//
//  Created by Leonid Mesentsev on 22/10/22.
//

import SwiftUI

struct CloseButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 20.0, height: 20.0)
            .foregroundColor(Color.TextColorSecondary)
            .padding(20)
    }
}
