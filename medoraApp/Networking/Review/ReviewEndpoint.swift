//
//  ReviewEndpoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 04.12.25.
//

import Foundation

enum ReviewEndpoint {
    case getReviews(doctorId: String)
    
    var path: String {
        switch self {
        case .getReviews(doctorId: let id):
            NetworkingHelper.shared.configUrl(endpoint: "/doctors/\(id)/reviews")
        }
    }
}
