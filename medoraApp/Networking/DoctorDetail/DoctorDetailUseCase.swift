//
//  DoctorDetailUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 02.12.25.
//

import Foundation

protocol DoctorDetailUseCase {
    func getDoctorDetail(endpoint: DoctorEndpoint, parameters: [String: String]?) async throws -> CoreModel<Doctor>?
}
