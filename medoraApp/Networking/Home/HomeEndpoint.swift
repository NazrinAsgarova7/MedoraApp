//
//  HomeEndpoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 21.11.25.
//

import Foundation

enum HomeEndpoint {
    case doctor(page: Int, limit: Int), getAllCategory
    case getDoctorByCategoryId(id: String)
    case search(query: String)
    
    var path: String {
        switch self {
        case .doctor(let page, let limit):
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/doctors?page=\(page)&limit=\(limit)")
        case .search(let query):
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/doctors?q=\(query)")
        case .getAllCategory:
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/categories")
        case .getDoctorByCategoryId(let id):
            NetworkingHelper.shared.configUrl(endpoint: "/catalog/doctors?categoryId=\(id)")
        }
    }
}
