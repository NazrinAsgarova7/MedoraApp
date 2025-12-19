//
//  AppointmentUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 19.12.25.
//

import Foundation

protocol AppointmentUseCase {
    func getAppointments(endpoint: AppointmentEndoint) async throws -> CoreModel<[Appointment]>?
    func getDoctorById(endpoint: AppointmentEndoint) async throws -> CoreModel<Doctor>?
}
