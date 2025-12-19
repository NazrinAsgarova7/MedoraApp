//
//  AppointmentsViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 19.12.25.
//

import Foundation

class AppointmentsViewModel {
    enum ViewState {
        case success
        case error(error: String)
    }
    let manager: AppointmentUseCase
    var completion: ((ViewState) -> Void)?
    var appointments: [Appointment]?
    var doctor: Doctor?
    
    init(manager: AppointmentUseCase) {
        self.manager = manager
    }
    
    func getUserAppointments() async {
        do {
            let result =  try await manager.getAppointments(endpoint: .getAppointments(userId: UserDefaultManager.shared.getData(key: .id)))
            appointments = result?.data
            Task {
                completion?(.success)
            }
        } catch {
            Task {
                completion?(.error(error: error.localizedDescription))
            }
        }
    }
    
    func getDoctorById(doctorId: String) async {
        do {
            let result =  try await manager.getDoctorById(endpoint: .getDoctorById(doctorId: doctorId))
            doctor = result?.data
            Task {
                completion?(.success)
            }
        } catch {
            Task {
                completion?(.error(error: error.localizedDescription))
            }
        }
    }
}
