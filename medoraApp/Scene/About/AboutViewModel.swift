//
//  AboutViewModel.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 26.12.25.
//

import Foundation

class AboutViewModel {
    enum ViewState {
        case success
        case error(error: String)
    }
    let manager: AboutUseCase
    var info: AboutModel?
    var completion: ((ViewState) -> Void)?
    
    init(manager: AboutUseCase) {
        self.manager = manager
    }
    
    func getAboutScreen() async {
        do {
            let result = try await manager.getAboutScreenInfo(endpoint: .getAbout)
            info = result?.data
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
