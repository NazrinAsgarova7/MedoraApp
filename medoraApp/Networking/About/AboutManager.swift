//
//  AboutManager.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 30.12.25.
//

import Foundation

class AboutManager: AboutUseCase {
    let adapter = NetworkingAdapter()
    
    func getAboutScreenInfo(endpoint: AboutEndpoint) async throws -> CoreModel<AboutModel>? {
        return try await adapter.request(url: endpoint.path, model: AboutModel.self)
    }
}
