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
    var appointments = [Appointment]()
    var doctor: Doctor?
    var data: CoreModel<[Appointment]>?

    
    init(manager: AppointmentUseCase) {
        self.manager = manager
    }
    
    func getUserAppointments() async {
        let page = (data?.pagination?.page ?? 0) + 1
        do {
            let data =  try await manager.getAppointments(endpoint: .getAppointments(userId: UserDefaultManager.shared.getData(key: .id), page: page, limit: 12))
            self.data = data
            self.appointments.append(contentsOf: data?.data ?? [])
            Task { @MainActor in
                completion?(.success)
            }
        } catch {
            Task { @MainActor in
                completion?(.error(error: error.localizedDescription))
            }
        }
    }
    
    //MARK: Pagination
    func pagination(index: Int) {
        guard let page = data?.pagination?.page else { return }
        guard let totalPage = data?.pagination?.totalPages else { return }
        
        if index == appointments.count - 2 && page < totalPage {
            Task {
                await getUserAppointments()
            }
        }
    }
    
    func removeAllData() {
        data = nil
        appointments.removeAll()
    }
}
