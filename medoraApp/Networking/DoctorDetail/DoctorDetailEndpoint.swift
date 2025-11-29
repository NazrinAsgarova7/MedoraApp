//
//  DoctorDetailEndpoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 29.11.25.
//

import Foundation

enum DoctorEndpoint {
    case getDetail(id: String)
    
    var path: String {
        switch self {
        case .getDetail(let id):
             NetworkingHelper.shared.configUrl(endpoint: "/doctors/\(id)")
        }
    }
}
