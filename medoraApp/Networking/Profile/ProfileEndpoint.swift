//
//  ProfileEndpoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 22.12.25.
//

import Foundation

enum ProfileEndpoint {
    case uploadPhoto(userId: String)
    
    var path: String {
        switch self {
        case .uploadPhoto(let id):
            NetworkingHelper.shared.configUrl(endpoint: "/auth/user/\(id)/photo")
        }
    }
}
