//
//  AboutUseCase.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 30.12.25.
//

import Foundation

protocol AboutUseCase {
    func getAboutScreenInfo(endpoint: AboutEndpoint) async throws -> CoreModel<AboutModel>?
}
