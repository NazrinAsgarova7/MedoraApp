//
//  HomeEndpoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 21.11.25.
//

import Foundation

enum HomeEndpoint {
    case doctor, getAllCategory
    case getDoctorByCategoryId(id: String)
    case search(query: String)
    
    var path: String {
        switch self {
        case .doctor:
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/doctors")
        case .search(let query):
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/doctors?q=\(query)")
        case .getAllCategory:
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/categories")
        case .getDoctorByCategoryId(let id):
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/doctors?categoryId=\(id)")
        }
    }
}
