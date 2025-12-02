//
//  DoctorDetailManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 29.11.25.
//

import Foundation
import Alamofire

class DoctorDetailManager: DoctorDetailUseCase {
    let adapter = NetworkingAdapter()
    
    func getDoctorDetail(endpoint: DoctorEndpoint, parameters: Parameters?) async throws -> DoctorDetailResult? {
        return try await adapter.request(url: endpoint.path, model: DoctorDetailResult.self, method: .get)
    }
    
}
