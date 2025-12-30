//
//  AboutScreen.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 30.12.25.
//

import Foundation

enum AboutEndpoint {
    case getAbout
    
    var path: String {
        switch self {
        case .getAbout:
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/about")
        }
    }
}
