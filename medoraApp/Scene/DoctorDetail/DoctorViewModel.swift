//
//  DoctorViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 29.11.25.
//

import Foundation

class DoctorViewModel {
    enum ViewState {
        case success
        case error(error: String)
    }
    let coordinator: DoctorDetailCoordinator
    let manager: DoctorDetailUseCase
    var doctorDetail: Doctor?
    var completion: ((ViewState) -> Void)?
    var id: String
    
    init(manager: DoctorDetailUseCase, doctorId: String, coordinator: DoctorDetailCoordinator) {
        self.coordinator = coordinator
        id = doctorId
        self.manager = manager
    }
    
    func getDoctorDetail() async {
        do {
            let result = try await manager.getDoctorDetail(endpoint: .getDetail(id: id), parameters: nil)
            doctorDetail = result?.data
            Task { @MainActor in
                completion?(.success)
            }
        } catch {
            Task { @MainActor in
                completion?(.error(error: error.localizedDescription))
            }
        }
    }
}
