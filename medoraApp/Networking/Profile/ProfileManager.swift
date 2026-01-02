//
//  ProfileManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 22.12.25.
//

import Foundation

class ProfileManager: ProfileUseCase {
    let adapter = NetworkingAdapter()
    
    func uploadProfilePhoto(endpoint: ProfileEndpoint, data: Data) async throws -> CoreModel<Profile>? {
        return try await adapter.uploadPhoto(url: endpoint.path, model: Profile.self, data: data)
    }
}
