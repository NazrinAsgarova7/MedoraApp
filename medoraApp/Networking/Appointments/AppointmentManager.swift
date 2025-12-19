//
//  AppointmentManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 19.12.25.
//

import Foundation
import Alamofire

class AppointmentManager: AppointmentUseCase {
    let adapter = NetworkingAdapter()
    
    func getAppointments(endpoint: AppointmentEndoint) async throws -> CoreModel<[Appointment]>? {
        return try await adapter.request(url: endpoint.path, model: [Appointment].self, method: .get)
    }
    
    func getDoctorById(endpoint: AppointmentEndoint) async throws -> CoreModel<Doctor>? {
        return try await adapter.request(url: endpoint.path, model: Doctor.self, method: .get)
    }
    
    
}
