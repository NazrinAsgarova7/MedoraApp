//
//  BookingEndpoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 15.12.25.
//

import Foundation

enum BookingEndpoint {
    case checkAvability(id: String, date: String)
    case bookDoctor(id: String)
    
    var path: String {
        switch self {
        case .checkAvability(let id, let date):
            NetworkingHelper.shared.configUrl(endpoint: "/availability/\(id)/availability?date=\(date)")
        case .bookDoctor(let id):
            NetworkingHelper.shared.configUrl(endpoint: "/appointments/\(id)/book")
        }
    }
}
