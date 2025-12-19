//
//  AppointEndoint.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 19.12.25.
//

import Foundation

enum AppointmentEndoint{
    case getAppointments(userId: String)
    case getDoctorById(doctorId: String)
    
    var path: String {
        switch self {
        case .getAppointments(let id):
            NetworkingHelper.shared.configUrl(endpoint: "/appointments/user/\(id)")
        case .getDoctorById(let id):
            NetworkingHelper.shared.configUrl(endpoint: "/doctors/\(id)")
        }
    }
}
