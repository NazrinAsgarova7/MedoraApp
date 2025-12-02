//
//  DoctorDetailUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 02.12.25.
//

import Alamofire

protocol DoctorDetailUseCase {
    func getDoctorDetail(endpoint: DoctorEndpoint, parameters: Parameters?) async throws -> DoctorDetailResult?
}
