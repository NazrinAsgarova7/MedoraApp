//
//  DoctorDetailManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 29.11.25.
//

import Foundation

class DoctorDetailManager: DoctorDetailUseCase {
    let adapter = NetworkingAdapter()
    
    func getDoctorDetail(endpoint: DoctorEndpoint, parameters: [String: String]?) async throws -> CoreModel<Doctor>? {
        return try await adapter.request(url: endpoint.path, model: Doctor.self, method: .get)
    }
}
