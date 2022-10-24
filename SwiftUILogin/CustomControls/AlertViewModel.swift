//
//  AlertViewModel.swift
//  LoginTest
//
//  Created by Leonid Mesentsev on 23/10/22.
//

import SwiftUI

typealias ConfirmCallback = () -> Void

final class AlertViewModel: ObservableObject {
    let systemImage: String?
    let image: String?
    let title: String
    let subtitle: String?
    let confirm: ConfirmCallback?
    let showClose: Bool
    
    init(systemImage: String? = nil, image: String? = nil, title: String, subtitle: String? = nil, showClose: Bool = false, confirm: ConfirmCallback? = nil) {
        self.image = image
        self.systemImage = systemImage
        self.title = title
        self.subtitle = subtitle
        self.showClose = showClose
        self.confirm = confirm
    }
}
