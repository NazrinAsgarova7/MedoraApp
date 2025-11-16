//
//  AuthEndpoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 13.11.25.
//

import Foundation

enum AuthEndpoint{
    case register, login
    
    var path: String {
        switch self {
        case .register:
            NetworkingHelper.shared.configUrl(endpoint: "/auth/register")
        case .login:
            NetworkingHelper.shared.configUrl(endpoint: "/auth/login")
        }
    }
}
