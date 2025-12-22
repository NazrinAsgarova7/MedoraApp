//
//  ProfileUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 22.12.25.
//

import Foundation

protocol ProfileUseCase {
    func uploadProfilePhoto(endpoint: ProfileEndpoint, data: Data) async throws -> CoreModel<Profile>?
}
