//
//  AppointEndoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 19.12.25.
//

import Foundation

enum AppointmentEndoint{
    case getAppointments(userId: String, page: Int, limit: Int)
    case getDoctorById(doctorId: String)
    
    var path: String {
        switch self {
        case .getAppointments(let id, let page, let limit):
            NetworkingHelper.shared.configUrl(endpoint: "/appointments/user/\(id)?page=\(page)&limit=\(limit)")
        case .getDoctorById(let id):
            NetworkingHelper.shared.configUrl(endpoint: "/doctors/\(id)")
        }
    }
}
